page 50205 Planner
{
    // //Tipos de Evento:
    // /***********************************************************************************************************
    // 1 --> Resize
    // 2 --> Change Service Item
    // 3 --> UnAssigned Service Order
    // 4 --> ViewOrder
    // 5 --> Assig Driver
    // 6 --> Assig Aux Operator
    // 7 --> Change Service Item Location
    // 8 --> Activate Movility
    // ************************************************************************************************************

    /*
    Caption = 'Planner';

    layout
    {
        area(content)
        {
            group(PlanificadorLinde)
            {
                Caption = ' ';
                usercontrol(Planner; "FAMPlanificador")
                {

                    trigger ControlAddInReady()
                    begin
                        IF bReady = FALSE THEN
                            UpdateControl;
                        bReady := TRUE;
                    end;

                    trigger Update(Params: DotNet Params)
                    var
                        UserDate: Record "User Date_LDR";
                    begin
                        IF NOT UserDate.GET(USERID) THEN BEGIN
                            UserDate."User Id" := USERID;
                            UserDate.Date := GetDate(Params.date);
                            UserDate.INSERT;
                        END ELSE BEGIN
                            UserDate.Date := GetDate(Params.date);
                            UserDate.MODIFY;
                        END;

                        //RefreshControl;
                        RefreshControl(Params.Filter);
                    end;

                    trigger EventAction(PlannerEvent: DotNet PlannerEvent)
                    begin
                        PlannerMgt.ProcessChange(PlannerEvent);

                        //IF PlannerEvent.EventType = '5' THEN
                        RefreshControl('');
                    end;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(General)
            {
                Caption = 'General';
                action("Create Order")
                {
                    Caption = 'Create Order';
                    Image = CreateDocument;

                    trigger OnAction()
                    var
                        ServiceOrderMgt: Codeunit "Service Order Mgt._LDR";
                    begin
                        ServiceOrderMgt.RUN;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        Value: Integer;
    begin
    end;

    var
        bReady: Boolean;
        txtAllocationUnfound: Label 'Other user has already modified Order %1 resource allocation. Update control to view updated changes.';
        EntryTypes: DotNet PlannerEvent;
        DateFormula: Record "Order Planner Setup_LDR";
        PlannerMgt: Codeunit "Planner Mgt._LDR";

    local procedure UpdateControl()
    var
        Groups: Record "Service Item Pres. Group_LDR";
        TempBlob: Record 99008535;
        OutXML: OutStream;
        InXML: InStream;
        Big: BigText;
    begin
        TempBlob.INIT;
        TempBlob.Blob.CREATEOUTSTREAM(OutXML, TEXTENCODING::Windows);
        XMLPORT.EXPORT(XMLPORT::"FAM Planner", OutXML, Groups);
        TempBlob.Blob.CREATEINSTREAM(InXML, TEXTENCODING::Windows);
        Big.READ(InXML);
        CurrPage.Planner.SendDataToControl(Big);
    end;

    local procedure RefreshControl(Params: Text)
    var
        Groups: Record "Service Item Pres. Group_LDR";
        TempBlob: Record "BLOB Storage Module"; //TODO: No encontrada
        OutXML: OutStream;
        InXML: InStream;
        Big: BigText;
        Params2: Text;
    begin
        TempBlob.INIT;
        //Comprobar pedidos con filtro StartDate <= Hoy <= FinishDate con dos SetRange.
        TempBlob.Blob.CREATEOUTSTREAM(OutXML, TEXTENCODING::Windows);
        XMLPORT.EXPORT(XMLPORT::"FAM Planner", OutXML, Groups);
        TempBlob.Blob.CREATEINSTREAM(InXML, TEXTENCODING::Windows);
        Big.READ(InXML);
        CurrPage.Planner.UpdateDataToControl(Big);
    end;

    /// <summary>
    /// GetTime.
    /// </summary>
    /// <param name="Value">Text.</param>
    /// <returns>Return value of type Time.</returns>
    procedure GetTime(Value: Text): Time
    var
        MyTextTime: Text;
        MyTime: Time;
    begin
        MyTextTime :=
          COPYSTR(Value, 12, 8);

        EVALUATE(MyTime, MyTextTime);
        EXIT(MyTime);
    end;

    /// <summary>
    /// GetDate.
    /// </summary>
    /// <param name="Value">Text.</param>
    /// <returns>Return value of type Date.</returns>
    procedure GetDate(Value: Text): Date
    var
        MyTextDate: Text;
        MyDate: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        EVALUATE(Year, COPYSTR(Value, 1, 4));
        EVALUATE(Month, COPYSTR(Value, 6, 2));
        EVALUATE(Day, COPYSTR(Value, 9, 2));

        MyDate := DMY2DATE(Day, Month, Year);
        EXIT(MyDate);
    end;
    */
}

