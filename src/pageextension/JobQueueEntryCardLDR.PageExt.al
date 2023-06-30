/// <summary>
/// PageExtension JobQueueEntryCard_LDR (ID 50088) extends Record Job Queue Entry Card.
/// </summary>
pageextension 50088 "JobQueueEntryCard_LDR" extends "Job Queue Entry Card"
{
    layout
    {
        addafter("No. of Minutes between Runs")
        {
            field("Notify On Success"; Rec."Notify On Success")
            {
                ApplicationArea = All;
                Caption = 'Notificar sobre el éxito';
                ToolTip = 'Notificar sobre el éxito';
            }
        }
    }
}