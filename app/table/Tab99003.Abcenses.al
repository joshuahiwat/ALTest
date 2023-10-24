table 99003 Absences
{
    Caption = 'Abcenses';
    DataClassification = CustomerContent;

    fields
    {
        field(10; Ulid; Code[20])
        {
            Caption = 'Ulid';
        }
        field(20; Reason; Enum AbsenceReason)
        {
            Caption = 'Reason';
        }
        field(30; Note; Text[140])
        {
            Caption = 'Note';
        }
        field(40; Registration; Code[26])
        {
            TableRelation = "Registration".Ulid;
            Caption = 'Registration';
        }
        field(50; Absence; Code[26])
        {
            Caption = 'Absence';
        }
        field(60; Status; Enum AbsenceStatus)
        {
            Caption = 'Status';
        }
    }
    keys
    {
        key(PK; Ulid)
        {
            Clustered = true;
        }
    }
}
