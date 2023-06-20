/// <summary>
/// Codeunit Service Order Mgt._LDR (ID 50004)
/// </summary>
codeunit 50004 "Service Order Mgt._LDR"
{
    /// <summary>
    /// AddServLine.
    /// </summary>
    /// <param name="myCode">Code[20].</param>
    /// <param name="Option_">Option.</param>
    /// <param name="Text2">Text.</param>
    /// <param name="Text3">Text.</param>
    /// <param name="Integer1">Integer.</param>
    /// <param name="Text4">Text.</param>
    /// <param name="Integer2">Integer.</param>
    /// <param name="myBoolean">Boolean.</param>
    procedure AddServLine(myCode: Code[20]; Option_: Option; Text2: Text; Text3: Text; Integer1: Integer; Text4: Text; Integer2: Integer; myBoolean: Boolean)
    begin

    end;

    /// <summary>
    /// AddExtraConceptLine.
    /// </summary>
    /// <param name="myCode">Code[20].</param>
    /// <param name="v">Record.</param>
    procedure AddExtraConceptLine(myCode: Code[20]; v: Record "Crane Serv Q Op Mic S Line_LDR")
    begin

    end;

    /// <summary>
    /// AddForfaitConceptLine.
    /// </summary>
    /// <param name="myCode">Code[20].</param>
    /// <param name="Rec">Record "Crane Serv Q. Forf Calend_LDR".</param>
    procedure AddForfaitConceptLine(myCode: Code[20]; Rec: Record "Crane Serv Q. Forf Calend_LDR")
    begin

    end;
}