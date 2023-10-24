permissionset 80104 "All Permissions"
{
    Access = Internal;
    Assignable = true;
    Caption = 'All permissions', Locked = true;
    Permissions = tabledata Absence=RIMD,
        tabledata Absences=RIMD,
        tabledata Registration=RIMD,
        table Absence=X,
        table Absences=X,
        table Registration=X,
        codeunit Absence=X,
        codeunit AbsenceContractTesting=X,
        codeunit Ulid=X;
}