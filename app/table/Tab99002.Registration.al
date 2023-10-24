table 99002 Registration
{
    Caption = 'Registration';
    DataClassification = CustomerContent;

    fields
    {
        field(10; Ulid; Code[26])
        {
            Caption = 'ulid';
        }
        field(20; Start; DateTime)
        {
            Caption = 'begin datetime';
        }
        field(30; "End"; DateTime)
        {
            Caption = 'end datetime';
        }
        field(40; "Type"; Text[100])
        {
            Caption = 'registration type';
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
