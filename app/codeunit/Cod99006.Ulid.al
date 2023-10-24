codeunit 99006 Ulid
{
    /**
    * <summary>Generates a ULID.</summary>
    */
    procedure Generate(): Text
    var
        DateTimeVal: DateTime;
        DateVal: Date;
        DurationVal: Duration;
    begin
        DurationVal := DateTimeVal - CreateDateTime(DateVal, 0T);
        exit(FromTimestamp(DurationVal / 10000));
    end;

    internal procedure Construct(
        TimeInternal: Text;
        RandomnessInternal: Text
    )
    begin
        Time := TimeInternal;
        Randomness := RandomnessInternal;
    end;

    internal procedure FromTimestamp(Miliseconds: Integer): Text
    var
        I: Integer;
        EncodingChars: Text;
        EncodingLength: Integer;
        TimeLength: Integer;
        ModLength: Integer;
        RandChars: Text;
        TxtBuilder: TextBuilder;
    begin
        EncodingChars := '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
        EncodingLength := 26;
        TimeLength := 10;

        for I := (TimeLength - 1) to I do begin
            ModLength := Miliseconds mod EncodingLength;
            TimeChars := EncodingChars[ModLength] + TimeChars;
            Miliseconds := (Miliseconds - ModLength) div EncodingLength;
            I := (I - 1);
        end;

        for I := 0 to (TimeLength - 1) do begin
            TxtBuilder.Append(EncodingChars[I]);
            I := (I + 1);
        end;

        Construct(TimeChars, RandChars);
    end;

    var
        TimeChars: Text;
        Now: Integer;
        Time: Text;
        Randomness: Text;
}
