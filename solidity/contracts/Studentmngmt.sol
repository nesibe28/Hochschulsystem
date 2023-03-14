
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
    Course[] coursesArray;

    mapping (address => Student) public students;
    mapping (address => Professor) public profs;
    mapping (int => Course) public courses;
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
        require(courses[_courseID].available, "Course is not yet available!");
        require(courses[_courseID].memberLimit>=courses[_courseID].memberCount, "Course already full");
        require(compareStrings(students[msg.sender].degree, courses[_courseID].degree), "Student has not the required degree!");
        require(students[msg.sender].semester == courses[_courseID].semester, "Student is not in the required semester!");
        EnrolledCourse[] memory enrolledCourses = eCourses[msg.sender];
        if(courses[_courseID].isCourseRequired) {
            require(enrolledCourses.length != 0, "Student does not have required courses!");
            int[] memory rc = requiredCourses[_courseID];
            for(uint i; i < rc.length; i++) {
                for(uint j; j < enrolledCourses.length; j++) {
                    if(enrolledCourses[j].student == msg.sender && enrolledCourses[j].ID == rc[i]) {


                        if(!enrolledCourses[j].takesPart || !enrolledCourses[j].passed) {
                            revert("Required Course not passed or taken Part in!");
                        }
                    } else if (enrolledCourses[j].ID == _courseID) {
                        revert("Course already passed or takes part in!");
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

    function getStudentDetails(address _student) public view returns (address, string memory, string memory, string memory, string memory, int) {
        Student memory s = students[_student];
        return (msg.sender, s.fName, s.lName, s.regAddress, s.degree, s.semester);
    }

    function updateRegAddressStudent(string memory _regAddress) public onlyStudent {
        students[msg.sender].regAddress = _regAddress;
    }

    function enrollInCourse(int _courseID) public onlyStudent checkEnrollmentInCourse(_courseID) {
        courses[_courseID].memberCount++;
        coursesArray[uint256(_courseID)].memberCount++;
        coursesArray.pop();
        EnrolledCourse memory ec = EnrolledCourse(_courseID, msg.sender, "0.0", true, false);
        eCourses[msg.sender].push(ec);
    }

    function unsubscribeFromCourse(int _courseID) public onlyStudent {
        EnrolledCourse[] memory enrolledCourses = eCourses[msg.sender];
        for(uint i; i < enrolledCourses.length; i++) {
            if(enrolledCourses[i].ID == _courseID && enrolledCourses[i].student == msg.sender) {
                require(!enrolledCourses[i].passed, "Course already passed, Unsubscription not possible");
                courses[_courseID].memberCount--;
                delete enrolledCourses[i];
            }
        }
        eCourses[msg.sender].pop();
    }

    function getEnrolledCourses(address _student) public view returns(EnrolledCourse[] memory) {
        return (eCourses[_student]);
    }

    function addNewCourse(int[] memory _requiredCourses, string memory _name, int _memberLimit, string memory _degree, int _semester, bool _isCourseRequired, address _createdByProf, bool _available) public onlyProfessor {
        courseCount = courseCount + 1;
        courses[courseCount] = Course(courseCount, _name, _memberLimit, 0, _degree, _semester, _isCourseRequired, _createdByProf, _available);
        if(_isCourseRequired) {
            requiredCourses[courseCount] = _requiredCourses;
        }
        coursesArray.push(Course(courseCount, _name, _memberLimit, 0, _degree, _semester, _isCourseRequired, _createdByProf, _available));
    }

    function getAllCourses() public view returns (Course[] memory) {
        return (coursesArray);
    }

    function getCourseDetails(int _courseID) public view returns (int, string memory, int, int, string memory, int, bool, address, bool) {
        Course memory c = courses[_courseID];
        return (_courseID, c.name, c.memberLimit, c.memberCount, c.degree, c.semester, c.isCourseRequired, c.createdByProf, c.available);
    }

    function getCourse(int _courseID) public view returns (Course memory) {
        return (courses[_courseID]);
    }

    function getSemesterFees(address _student) public view onlyStudent returns(SemesterRegistration[] memory) {
        return (semesterFees[_student]);
    }

    function addSemesterToPay(address _student, string memory _semester) public onlyProfessor {
        SemesterRegistration memory fee = SemesterRegistration(0.0, _semester, _student, false);
        semesterFees[_student].push(fee);
    }

    function paySemester(string memory _semester) public payable onlyStudent {
        require(msg.value == 0.05 ether, "Value does not match SemesterFee!");
        tokenCount++;
        SemesterRegistration[] memory fees = semesterFees[msg.sender];
        for(uint i; i < fees.length; i++) {
            if(compareStrings(fees[i].semester, _semester) && fees[i].student == msg.sender) {
                require(!fees[i].isPayed, "Semester Fee already payed!");
                fees[i].isPayed = true;
                fees[i].tokenID = tokenCount;
            }
        }
        semesterFees[msg.sender].pop();
        newToken.pay(msg.sender, tokenCount);
    }

    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}