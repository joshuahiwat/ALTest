table 99001 Absence
{
    Caption = 'Absence';
    DataClassification = CustomerContent;

    fields
    {
        field(10; Ulid; Code[26])
        {
            Caption = 'ulid';
        }
        field(20; Employee; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'employee';
        }
        field(30; Registration; Code[26])
        {
            TableRelation = Registration.Ulid;
            Caption = 'registration';
        }
        field(40; Status; Enum AbsenceStatus)
        {
            Caption = 'status';
        }
    }
    keys
    {
        key(PK; ulid)
        {
            Clustered = true;
        }
    }
}
