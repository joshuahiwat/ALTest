codeunit 99007 Absence implements AbsenceContract
{
    procedure Construct(
        var StartDateTimeParam: DateTime;
        var EndDateTimeParam: DateTime;
        var ReasonParam: Enum AbsenceReason;
        var NoteParam: Text[140];
        var EmployeeParam: Record Employee
    )
    begin
        StartDateTime := StartDateTimeParam;
        EndDateTime := EndDateTimeParam;
        Reason := ReasonParam;
        Note := NoteParam;
        Employee := EmployeeParam;
    end;

    procedure Create(): Boolean
    begin
        ValidateAbsenceTimestamp;

        if ValidateRegistration(Absence.TableName) then begin
            exit(SetAbsence);
        end else
            exit(SetAbsenceLine(false));
    end;

    internal procedure SetAbsence(): Boolean
    begin
        AbsenceUlid := GetUlid.Generate;
        Absence.init;
        Absence.Validate(Absence.Ulid, AbsenceUlid);
        Absence.Validate(Absence.Registration, RegistrationUlid);
        Absence.Validate(Absence.Employee, Employee."No.");
        Absence.Validate(Absence.Status, AbsenceStatus::Pending);

        if (Absence.Insert AND SetRegistration(Absence.TableName)) then
            exit(SetAbsenceLine(true));
    end;

    internal procedure SetAbsenceLine(NewEntry: Boolean): Boolean
    begin
        if NewEntry then
            AbsenceUlid := GetAbsenceBasedOnRegistration.Ulid;

        AbsenceLineUlid := GetUlid.Generate;
        Absences.init;
        Absences.Validate(Absences.Ulid, AbsenceLineUlid);
        Absences.Validate(Absences.Absence, AbsenceUlid);
        Absences.Validate(Absences.Registration, RegistrationUlid);
        Absences.Validate(Absences.Reason, Reason);
        Absences.Validate(Absences.Note, Note);

        exit((Absences.Insert AND SetRegistration(Absences.TableName)))
    end;

    internal procedure SetRegistration(Type: Text[100]): Boolean
    begin
        RegistrationUlid := GetUlid.Generate;
        Registration.init;
        Registration.Validate(Registration.Ulid, RegistrationUlid);
        Registration.Validate(Registration.Start, StartDateTime);
        Registration.Validate(Registration."End", EndDateTime);
        Registration.Validate(Registration.Type, Type);

        exit(Registration.Insert);
    end;

    internal procedure GetAbsenceBasedOnRegistration(): Record Absence
    begin
        if (Registration.FindFirst) then
            repeat
                if (StartDateTime >= Registration.Start) AND (StartDateTime <= Registration."End") then begin
                    Absence.SetRange(Absence.Registration, Registration.Ulid);
                    if (Absence.FindFirst) then
                        exit(Absence);
                end;
            until Registration.next = 0;
    end;

    internal procedure ValidateAbsenceTimestamp()
    begin
        if StartDateTime > EndDateTime then
            error('Start date time cannot be greater than end date time');
    end;

    internal procedure ValidateRegistration(Type: Text[100]): Boolean
    begin
        Registration.SetRange(Registration."Type", Type);
        if (Registration.FindFirst) then
            repeat
                if (StartDateTime >= Registration.Start) AND (StartDateTime <= Registration."End") then
                    exit(false);
            until Registration.next = 0;

        exit(true);
    end;

    var
        Employee: Record Employee;
        AbsenceUlid: Text;
        RegistrationUlid: Text;
        AbsenceLineUlid: Text;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Reason: Enum AbsenceReason;
        Note: Text[140];
        Registration: Record Registration;
        Absence: Record Absence;
        Absences: Record Absences;
        GetUlid: Codeunit Ulid;
}
