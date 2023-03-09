
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./SemesterToken.sol";

contract Studentmngmt {

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

    modifier checkEnrollmentInCourse(address _studentAddress, int _courseID)
    {
        require(courses[_courseID].available, "Course is not yet available!");
        require(courses[_courseID].memberLimit>=courses[_courseID].memberCount, "Course already full");
        require(compareStrings(students[_studentAddress].degree, courses[_courseID].degree), "Student has not the required degree!");
        require(students[_studentAddress].semester == courses[_courseID].semester, "Student is not in the required semester!");
        EnrolledCourse[] memory enrolledCourses = eCourses[_studentAddress];
        if(courses[_courseID].isCourseRequired) {
            require(enrolledCourses.length != 0, "Student does not have required courses!");
            int[] memory rc = requiredCourses[_courseID];
            for(uint i; i < rc.length; i++) {
                for(uint j; j < enrolledCourses.length; j++) {
                    if(enrolledCourses[j].student == _studentAddress && enrolledCourses[j].ID == rc[i]) {
                        if(!enrolledCourses[j].takesPart || !enrolledCourses[j].passed) {
                            revert("Course not passed or taken Part in!");
                        }
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

    function getStudentDetails(address _studentAddress) public view returns (address, string memory, string memory, string memory, string memory, int) {
        Student memory s = students[_studentAddress];
        return (_studentAddress, s.fName, s.lName, s.regAddress, s.degree, s.semester);
    }

    function updateRegAddressStudent(address _studentAddress, string memory _regAddress) public onlyStudent {
        students[_studentAddress].regAddress = _regAddress;
    }

    function enrollInCourse(address _studentAddress, int _courseID) public onlyStudent checkEnrollmentInCourse(_studentAddress, _courseID) {
        Course memory c = getCourse(_courseID);
        c.memberCount = c.memberCount + 1;
        EnrolledCourse memory ec = EnrolledCourse(_courseID, _studentAddress, "0.0", true, false);
        eCourses[_studentAddress].push(ec);
    }

    function getEnrolledCourses(address _studentAddress) public view returns(EnrolledCourse[] memory) {
        return (eCourses[_studentAddress]);
    }

    function unsubscribeFromCourse(address _studentAddress, int _courseID) public onlyStudent {
        EnrolledCourse[] memory enrolledCourses = eCourses[_studentAddress];
        for(uint i; i < enrolledCourses.length; i++) {
            if(enrolledCourses[i].ID == _courseID && enrolledCourses[i].student == _studentAddress) {
                delete enrolledCourses[i];
            }
        }
        eCourses[_studentAddress].pop();
    }

    function addNewCourse(int[] memory _requiredCourses, string memory _name, int _memberLimit, string memory _degree, int _semester, bool _isCourseRequired, address _createdByProf, bool _available) public  {
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

    function getSemesterFees(address _studentAddress) public view returns(SemesterRegistration[] memory) {
        return (semesterFees[_studentAddress]);
    }

    function addSemesterToPay(address _studentAddress, string memory _semester) public {
        SemesterRegistration memory fee = SemesterRegistration(0.0, _semester, _studentAddress, false);
        semesterFees[_studentAddress].push(fee);
    }

    function paySemester(address _studentAddress, string memory _semester) public payable onlyStudent {
        require(msg.value == 0.05 ether, "Value does not match SemesterFee!");
        tokenCount++;
        SemesterRegistration[] memory fees = semesterFees[_studentAddress];
        for(uint i; i < fees.length; i++) {
            if(compareStrings(fees[i].semester, _semester) && fees[i].student == _studentAddress) {
                require(!fees[i].isPayed, "Semester Fee already payed!");
                fees[i].isPayed = true;
                fees[i].tokenID = tokenCount;
            }
        }
        semesterFees[_studentAddress].pop();
        newToken.pay(_studentAddress, tokenCount);
    }

    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

}