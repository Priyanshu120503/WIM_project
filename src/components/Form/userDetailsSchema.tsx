import { object, string, number } from "yup";

export const getUserDetailsSchema = () =>
  object({
    fullName: string().required(`Full Name field is required`),
    gender: string().required("Gender is required"),
    emailID: string()
      .email("Invalid Email address")
      .required(`Email is required`),
    contact: number().required("Contact number is required"),
    dob: string().required("DOB is required"),
    address: string().required("Address is required"),
    pinCode: number().required("Pin code is required"),
    sourceStation: string().required("Source station is required"),
    destinationStation: string().required("Destination station is required"),
    prevPassNumber: string().required("Previous pass number is required"),
    reEnterPrevPassNumber: string()
      .test(
        "prevPassNumber",
        "Previous Pass Number should match",
        function (reEnterPrevPassNumber) {
          return reEnterPrevPassNumber === this.parent.prevPassNumber;
        }
      )
      .required("Re-enter previous pass number"),
    oldPassExpiryDate: string().required("Old pass expiry date is required"),
    branch: string().required("Branch name is required"),
    academicYear: string().required("Academic year is required"),
    semester: string().required("Semester number is required"),
    passDuration: string().required("Pass duration is required"),
    travelClass: string().required("Travel class is required"),
  });
