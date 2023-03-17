
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./SemesterToken.sol";

contract Studentmngmt {

    //STRUCTS-START////////////////////////////////////////////////////////////////////////////////////////////////

    struct Student
    {
        address studentAddress;
        string fName;
        string lName;
        string regAddress;
        string degree;
        int semester;
    }

    struct Professor
    {
        address profAddress;
        string fName;
        string lName;
    }

    struct EnrolledCourse
    {
        int ID;
        address student;
        string mark;
        bool takesPart;
        bool passed;
    }

    struct Course
    {
        int ID;
        string name;
        int memberLimit;
        int memberCount;
        string degree;
        int semester;
        bool isCourseRequired;
        address createdByProf;
        bool available;
    }

    struct SemesterRegistration
    {
        uint256 tokenID;
        string semester;
        address student;
        bool isPayed;
    }

    //STRUCTS-END////////////////////////////////////////////////////////////////////////////////////////////////

    //VARIABLES-START////////////////////////////////////////////////////////////////////////////////////////////////

    int public courseCount;
    uint256 public tokenCount;
    SemesterToken newToken = new SemesterToken();

    address[] studentsAddresses;
    address[] profsAddresses;
    Course[] courses;

    mapping (address => Student) public students;
    mapping (address => Professor) public profs;
    mapping (address => EnrolledCourse[]) public eCourses;
    mapping (int => int[]) public requiredCourses;
    mapping (address => SemesterRegistration[]) public semesterFees;

    //VARIABLES-END////////////////////////////////////////////////////////////////////////////////////////////////

    //MODIFIER-START////////////////////////////////////////////////////////////////////////////////////////////////

    modifier onlyStudent()
    {
        require(students[msg.sender].studentAddress != address(0), "Only Student can call this!");
        _;
    }

    modifier onlyProfessor()
    {
        require(profs[msg.sender].profAddress != address(0), "Only Professor can call this!");
        _;
    }

    modifier checkEnrollmentInCourse(int _courseID)
    {
        require(courses[uint256(_courseID)-1].available, "Course is not yet available!");
        require(courses[uint256(_courseID)-1].memberLimit > courses[uint256(_courseID)-1].memberCount, "Course already full");
        require(compareStrings(students[msg.sender].degree, courses[uint256(_courseID)-1].degree), "Student has not the required degree!");
        require(students[msg.sender].semester == courses[uint256(_courseID)-1].semester, "Student is not in the required semester!");
        EnrolledCourse[] memory enrolledCourses = eCourses[msg.sender];
        if(courses[uint256(_courseID)-1].isCourseRequired) {
            require(enrolledCourses.length != 0, "Student does not have required courses!");
            int[] memory rc = requiredCourses[_courseID];
            for(uint i; i < rc.length; i++) {
                for(uint j; j < enrolledCourses.length; j++) {
                    require(enrolledCourses[j].ID != _courseID, "Course already passed or takes part in!");
                    if(enrolledCourses[j].student == msg.sender && enrolledCourses[j].ID == rc[i]) {
                        require(enrolledCourses[j].takesPart || enrolledCourses[j].passed, "Required Course not passed or taken Part in!");
                    }
                }
            }
        }
        _;
    }

    //MODIFIER-END////////////////////////////////////////////////////////////////////////////////////////////////

    constructor()
    {

    }

    function getAllStudentAddresses() public view returns (address[] memory) {
        return (studentsAddresses);
    }

    function getAllProfessorAddresses() public view returns (address[] memory) {
        return (profsAddresses);
    }

    function addNewProfessor(address _profAddress, string memory _fName, string memory _lName) public {
        profs[_profAddress] = Professor(_profAddress, _fName, _lName);
        profsAddresses.push(_profAddress);
    }

    function addNewStudent(address _studentAddress, string memory _fName, string memory _lName, string memory _regAddress, string memory _degree, int _semester) public {
        students[_studentAddress] = Student(_studentAddress, _fName, _lName, _regAddress, _degree, _semester);
        studentsAddresses.push(_studentAddress);
    }

    function getStudentDetails(address _student) public view returns (string memory, string memory, string memory, string memory, int) {
        Student memory s = students[_student];
        return (s.fName, s.lName, s.regAddress, s.degree, s.semester);
    }

    function updateRegAddressStudent(string memory _regAddress) public onlyStudent {
        students[msg.sender].regAddress = _regAddress;
    }

    function addNewCourse(int[] memory _requiredCourses, string memory _name, int _memberLimit, string memory _degree, int _semester, bool _isCourseRequired, address _createdByProf, bool _available) public onlyProfessor {
        courseCount = courseCount + 1;
        if(_isCourseRequired) {
            requiredCourses[courseCount] = _requiredCourses;
        }
        courses.push(Course(courseCount, _name, _memberLimit, 0, _degree, _semester, _isCourseRequired, _createdByProf, _available));
    }

    function enrollInCourse(int _courseID) public onlyStudent checkEnrollmentInCourse(_courseID) {
        EnrolledCourse[] memory enrolledCourses = eCourses[msg.sender];
        if(enrolledCourses.length != 0) {
            for(uint j; j < enrolledCourses.length; j++) {
                require(enrolledCourses[j].ID != _courseID, "Course already passed or takes part in!");
            }
        }
        courses[uint256(_courseID)-1].memberCount++;
        //coursesArray.pop();
        EnrolledCourse memory ec = EnrolledCourse(_courseID, msg.sender, "0.0", true, false);
        eCourses[msg.sender].push(ec);
    }

    function unsubscribeFromCourse(int _courseID) public onlyStudent {
        EnrolledCourse[] memory enrolledCourses = eCourses[msg.sender];
        for(uint i; i < enrolledCourses.length; i++) {
            if(enrolledCourses[i].ID == _courseID && enrolledCourses[i].student == msg.sender) {
                require(!enrolledCourses[i].passed, "Course already passed, Unsubscription not possible");
                courses[uint256(_courseID)-1].memberCount--;
                delete enrolledCourses[i];
            }
        }
        eCourses[msg.sender].pop();
    }

    function getEnrolledCourses(address _student) public view returns(EnrolledCourse[] memory) {
        return (eCourses[_student]);
    }

    function updateMarkOfStudent(address _student, int _courseID, string memory _mark) public onlyProfessor {
        EnrolledCourse[] storage enrolledCourses = eCourses[_student];
        for(uint i; i < enrolledCourses.length; i++) {
            if(enrolledCourses[i].ID == _courseID) {
                enrolledCourses[i].mark = _mark;
            }
        }
    }

    function getAllCourses() public view returns (Course[] memory) {
        return (courses);
    }

    function getSemesterFees(address _student) public view returns(SemesterRegistration[] memory) {
        return (semesterFees[_student]);
    }

    function addSemesterToPay(address _student, string memory _semester) public onlyProfessor {
        tokenCount++;
        SemesterRegistration memory fee = SemesterRegistration(tokenCount, _semester, _student, false);
        semesterFees[_student].push(fee);
    }

    function paySemester(string memory _semester) public payable onlyStudent {
        require(msg.value == 0.05 ether, "Value does not match SemesterFee!");
        SemesterRegistration[] storage fees = semesterFees[msg.sender];
        for(uint i; i < fees.length; i++) {
            if(compareStrings(fees[i].semester, _semester)) {
                require(!fees[i].isPayed, "Semester Fee already payed!");
                fees[i].isPayed = true;
                newToken.pay(msg.sender, fees[i].tokenID);
            }
        }
    }

    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}