codeunit 99008 AbsenceContractTesting
{
    Subtype = Test;

    [Test]
    procedure CreateAbsenceTest()
    var
        AbsenceContract: Codeunit Absence;
        Assertion: Boolean;
    begin
        Assertion := SetAbsence(AbsenceContract);
        Assert.IsTrue(not Assertion, 'Absence contract was not created.');
    end;

    internal procedure SetAbsence(AbsenceContract: Interface AbsenceContract): Boolean
    var
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Employee: Record Employee;
    begin
        StartDateTime := CURRENTDATETIME; // Current date and time
        EndDateTime := (StartDateTime + 8); // Add 8 hours to current date and time
        AbsenceContract.Construct(
            StartDateTime,
            EndDateTime,
            AbsenceReason::Doctor,
            'Lorem Ipsum',
            Employee
        );

        exit(AbsenceContract.Create);
    end;

    var
        Assert: Codeunit "Library Assert";
}
