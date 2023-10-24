interface AbsenceContract
{
    /**
    * <summary>Initilize an absence contract</summary>
    * <param name="StartDateTime">Start date and time of the absence</param>
    * <param name="EndDateTime">End date and time of the absence</param>
    * <param name="Reason">Reason of the absence</param>
    * <param name="Note">Note of the absence</param>
    * <param name="Employee">Employee of the absence</param>
    */
    procedure Construct(
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Reason: Enum AbsenceReason;
        Note: Text[140];
        Employee: Record Employee
    );

    /**
    * <summary>Create an absence</summary>
    */
    procedure Create(): Boolean

}
