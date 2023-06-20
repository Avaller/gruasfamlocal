page 50015 "Alarm List"
{
    Caption = 'Alarm List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Alarms_LDR;
    /*
    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Alarm No."; "Alarm No.")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Message Type"; "Message Type")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("Source No."; "Source No.")
                {
                }
                field("Source No. 2"; "Source No. 2")
                {
                }
                field(Message; Message)
                {
                }
                field("Message 2"; "Message 2")
                {
                }
                field("Off on next use"; "Off on next use")
                {
                }
                field("User ID"; "User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Alarm")
            {
                Caption = '&Alarm';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page 70104;
                    RunPageLink = Alarm No.=FIELD(Alarm No.);
                    ShortCutKey = 'Shift+F7';
                }
                separator()
                {
                }
                action(Logs)
                {
                    Caption = 'Logs';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page 70105;
                                    RunPageLink = Alarm No.=FIELD(Alarm No.);
                    RunPageView = SORTING(Alarm No.,Date,Time);
                }
            }
        }
    }
    */
}