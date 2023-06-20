/// <summary>
/// Codeunit Alarm Mgt._LDR (ID 50209)
/// </summary>
codeunit 50209 "Alarm Mgt._LDR"
{
    trigger OnRun()
    var
        Cust: Record "Customer";
        Recordreference: RecordRef;
    begin
        /*
        CLEAR(Cust);
        Cust.SETRANGE(Cust."No.",'430000004');
        Cust.SETFILTER(Cust.Balance,'>%1',2000);
        IF Cust.FINDFIRST THEN;
        Recordreference.OPEN(DATABASE::Customer);
        Recordreference.SETVIEW(Cust.GETVIEW);
        ERROR(Recordreference.GETVIEW);
        */
        CheckAlarm(DATABASE::"Sales Header", '430001289', '', '', WORKDATE, 2, 0, 0);

    end;

    /// <summary>
    /// CheckAlarm()
    /// </summary>
    procedure CheckAlarm(SourceTableNo: Integer; SourceFieldName: Text[80]; SourceNo: Code[20]; SourceNo2: Code[20]; AlarmDate: Date; SalesDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; PurchDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; ServDocType: Option Quote,"Order",Invoice,"Credit Memo",Shipment)
    var
        Alarms: Record "Alarms_LDR";
    begin
        CLEAR(Alarms);
        Alarms.SETFILTER(Alarms."Start Date", '<=%1|%2', AlarmDate, 0D);
        Alarms.SETFILTER(Alarms."End Date", '>=%1|%2', AlarmDate, 0D);

        CASE SourceTableNo OF
            DATABASE::"Service Contract Header":
                BEGIN
                    // Cliente
                    Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::Customer);
                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    Alarms.SETRANGE(Alarms."Serv. Contract", TRUE);
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;
                END;
            DATABASE::"Service Contract Line":
                BEGIN
                    // Producto Servicio
                    Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::"Service Item");
                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    Alarms.SETRANGE(Alarms."Serv. Contract", TRUE);
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;

                END;
            // DATABASE::Table70029: //TODO: Error: La DATABASE no contiene la tabla 70029
            //     BEGIN
            //         // Producto Servicio
            //         Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::"Service Item");
            //         Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
            //         Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
            //         Alarms.SETRANGE(Alarms."Int. Serv. Contract", TRUE);
            //         IF Alarms.FINDSET THEN BEGIN
            //             REPEAT
            //                 IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
            //                     ShowAlarm(Alarms, SourceTableNo);
            //             UNTIL Alarms.NEXT = 0;
            //         END;
            //     END;

            DATABASE::"Sales Header":
                BEGIN
                    // Cliente
                    Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::Customer);
                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    CASE SalesDocType OF
                        SalesDocType::Quote: // Quote
                            BEGIN
                                Alarms.SETRANGE(Alarms."Sales Quote", TRUE);
                            END;
                        SalesDocType::Order: // Order
                            BEGIN
                                Alarms.SETRANGE(Alarms."Sales Order", TRUE);
                            END;
                        SalesDocType::Invoice: // Invoice
                            BEGIN
                                Alarms.SETRANGE(Alarms."Sales Invoice", TRUE);
                            END;
                        SalesDocType::"Credit Memo": // CrMemo
                            BEGIN
                                Alarms.SETRANGE(Alarms."Sales Cr. Memo", TRUE);
                            END;
                    END;
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;
                END;
            DATABASE::"Service Item Line":
                BEGIN
                    // Producto Servicio
                    Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::"Service Item");
                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    CASE ServDocType OF
                        ServDocType::Quote: // Quote
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Quote", TRUE);
                            END;
                        ServDocType::Order: // Order
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Order", TRUE);
                            END;
                        ServDocType::Invoice: // Invoice
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Invoice", TRUE);
                            END;
                        ServDocType::"Credit Memo": // CrMemo
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Cr. Memo", TRUE);
                            END;
                        ServDocType::Shipment: // Shipment
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Shipment", TRUE);
                            END;

                    END;
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;

                END;

            DATABASE::"Service Line": // Facturas y abonos de servicio
                BEGIN
                    // Producto Servicio
                    Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::"Service Item");
                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    CASE ServDocType OF
                        ServDocType::Quote: // Quote
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Quote", TRUE);
                            END;
                        ServDocType::Order: // Order
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Order", TRUE);
                            END;
                        ServDocType::Invoice: // Invoice
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Invoice", TRUE);
                            END;
                        ServDocType::"Credit Memo": // CrMemo
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Cr. Memo", TRUE);
                            END;
                        ServDocType::Shipment: // Shipment
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Shipment", TRUE);
                            END;

                    END;
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;

                END;

            DATABASE::"Purchase Header":
                BEGIN
                    // Proveedor
                    // Cliente
                    Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::Vendor);
                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    CASE PurchDocType OF
                        PurchDocType::Quote: // Quote
                            BEGIN
                                Alarms.SETRANGE(Alarms."Purch. Quote", TRUE);
                            END;
                        PurchDocType::Order: // Order
                            BEGIN
                                Alarms.SETRANGE(Alarms."Purch. Order", TRUE);
                            END;
                        PurchDocType::Invoice: // Invoice
                            BEGIN
                                Alarms.SETRANGE(Alarms."Purch. Invoice", TRUE);
                            END;
                        PurchDocType::"Credit Memo": // CrMemo
                            BEGIN
                                Alarms.SETRANGE(Alarms."Purch. Cr. Memo", TRUE);
                            END;
                    END;
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;

                END;
            DATABASE::"Service Header":
                BEGIN
                    CASE SourceFieldName OF
                        'Customer No.', 'Ship-to Code':
                            Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::Customer);            // Cliente
                        'Contract No.':
                            Alarms.SETRANGE(Alarms."Source Type", Alarms."Source Type"::Contract);            // Contrato
                    END;

                    Alarms.SETFILTER(Alarms."Source No.", '%1|%2', SourceNo, '');
                    Alarms.SETFILTER(Alarms."Source No. 2", '%1|%2', SourceNo2, '');
                    CASE ServDocType OF
                        ServDocType::Quote: // Quote
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Quote", TRUE);
                            END;
                        ServDocType::Order: // Order
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Order", TRUE);
                            END;
                        ServDocType::Invoice: // Invoice
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Invoice", TRUE);
                            END;
                        ServDocType::"Credit Memo": // CrMemo
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Cr. Memo", TRUE);
                            END;
                        ServDocType::Shipment: // Shipment
                            BEGIN
                                Alarms.SETRANGE(Alarms."Serv. Shipment", TRUE);
                            END;

                    END;
                    IF Alarms.FINDSET THEN BEGIN
                        REPEAT
                            IF IsInFilter(Alarms, SourceNo, SourceNo2) THEN
                                ShowAlarm(Alarms, SourceTableNo);
                        UNTIL Alarms.NEXT = 0;
                    END;
                END;
        END;
    end;

    /// <summary>
    /// ShowAlarm()
    /// </summary>
    procedure ShowAlarm(Alarm: Record "Alarms_LDR"; SourceTableNo: Integer)
    var
        TextConfirm: Label '%1\¿Do you want to continue?';
    begin
        CASE Alarm."Message Type" OF
            Alarm."Message Type"::Warning:
                BEGIN
                    IF CONFIRM(STRSUBSTNO(TextConfirm, Alarm.Message + '\' + Alarm."Message 2"), FALSE) THEN BEGIN
                        CreateAlarmLog(Alarm, TRUE, SourceTableNo);
                        CheckUnactivate(Alarm);
                    END ELSE BEGIN
                        CreateAlarmLog(Alarm, FALSE, SourceTableNo);
                        CheckUnactivate(Alarm);
                        COMMIT;
                        ERROR('');
                    END;
                END;
            Alarm."Message Type"::Error:
                BEGIN
                    CreateAlarmLog(Alarm, TRUE, SourceTableNo);
                    CheckUnactivate(Alarm);
                    COMMIT;
                    ERROR(Alarm.Message + ' - ' + Alarm."Message 2");
                END;
        END;
    end;

    /// <summary>
    /// CreateAlarmLog()
    /// </summary>
    procedure CreateAlarmLog(Alarm: Record "Alarms_LDR"; Accepted: BoolEAN; SourceTableNo: Integer)
    var
        TempLog: Record "Alarms Log_LDR";
        NewLog: Record "Alarms Log_LDR";
    begin
        CLEAR(TempLog);
        IF TempLog.FINDLAST THEN;

        NewLog."Entry No." := TempLog."Entry No." + 1;
        NewLog."Alarm No." := Alarm."Alarm No.";
        NewLog.Date := TODAY;
        NewLog.Time := TIME;
        NewLog."User ID" := USERID;
        IF Accepted THEN
            NewLog.Action := TempLog.Action::Accepted
        ELSE
            NewLog.Action := TempLog.Action::Rejected;
        NewLog.VALIDATE("Source table No.", SourceTableNo);
        NewLog.INSERT(TRUE);
    end;

    /// <summary>
    /// IsInFilter()
    /// </summary>
    procedure IsInFilter(Alarm: Record "Alarms_LDR"; SourceNo: Code[20]; SourceNo2: Code[20]): BoolEAN
    var
        // AlarmFilters: Record 70071; //TODO: No existe la Tabla 70071
        Customer: Record "Customer";
        ShipToAddress: Record "Ship-to Address";
        Vendor: Record "Vendor";
        OrderAddress: Record "Order Address";
        Contract: Record "Service Contract Header";
        ServiceItem: Record "Service Item";
        Recordreference: RecordRef;
        TempFilter: Text[1024];
        TempFilter2: Text[1024];
        Counter: Integer;
        Contador: Integer;
    begin
        Counter := 0;

        // CLEAR(AlarmFilters);
        // AlarmFilters.SETRANGE(AlarmFilters."Alarm No.", Alarm."Alarm No.");

        CASE Alarm."Source Type" OF
            Alarm."Source Type"::Customer:
                BEGIN
                    // Dirección de envio
                    IF (SourceNo2 <> '') AND (Alarm."Source No. 2" <> '') THEN BEGIN
                        TempFilter := 'SORTING (' +
                                      ShipToAddress.FIELDCAPTION("Customer No.") + ',' +
                                      ShipToAddress.FIELDCAPTION(Code) + ')' +
                                      ' WHERE(' +
                                      ShipToAddress.FIELDCAPTION("Customer No.") + '=FILTER(' + SourceNo + '),' +
                                      ShipToAddress.FIELDCAPTION(Code) + '=FILTER(' + SourceNo2 + ')';
                    END ELSE BEGIN
                        // Cliente
                        TempFilter := 'SORTING (' + Customer.FIELDCAPTION(Customer."No.") + ')' +
                                    ' WHERE(' + Customer.FIELDCAPTION(Customer."No.") + '=FILTER(' + SourceNo + ')';
                    END;

                END;
            Alarm."Source Type"::Vendor:
                // Dirección de envio
                IF (SourceNo2 <> '') AND (Alarm."Source No. 2" <> '') THEN BEGIN
                    TempFilter := 'SORTING (' +
                                  OrderAddress.FIELDCAPTION("Vendor No.") + ',' +
                                  OrderAddress.FIELDCAPTION(Code) + ')' +
                                  ' WHERE(' +
                                  OrderAddress.FIELDCAPTION("Vendor No.") + '=FILTER(' + SourceNo + '),' +
                                  OrderAddress.FIELDCAPTION(Code) + '=FILTER(' + SourceNo2 + ')';
                END ELSE BEGIN
                    TempFilter := 'SORTING (' + Vendor.FIELDCAPTION(Vendor."No.") + ')' +
                                  ' WHERE(' + Vendor.FIELDCAPTION(Vendor."No.") + '=FILTER(' + SourceNo + ')';
                END;
            Alarm."Source Type"::"Service Item":
                TempFilter := 'SORTING (' + ServiceItem.FIELDCAPTION(ServiceItem."No.") + ')' +
                              ' WHERE(' + ServiceItem.FIELDCAPTION(ServiceItem."No.") + '=FILTER(' + SourceNo + ')';

            Alarm."Source Type"::Contract:
                TempFilter := 'SORTING (' +
                             Contract.FIELDCAPTION(Contract."Contract Type") + ',' + FORMAT(Contract."Contract Type"::Contract) + ') '
                             + ' WHERE(' + Contract.FIELDCAPTION(Contract."Contract Type") + '=FILTER(' +
                             FORMAT(Contract."Contract Type"::Contract) + '),' + Contract.FIELDCAPTION(Contract."Contract No.") +
                             '=FILTER(' + SourceNo + ')';
        END;

        TempFilter2 := '';

        // IF AlarmFilters.FINDSET THEN BEGIN
        //     REPEAT
        //         TempFilter2 := TempFilter2 + ', ';
        //         TempFilter2 := TempFilter2 + AlarmFilters."Field Caption" + '=FILTER(' + AlarmFilters.Filter + ')';
        //     UNTIL AlarmFilters.NEXT = 0;
        // END;

        TempFilter2 := TempFilter2 + ')';

        CASE Alarm."Source Type" OF
            Alarm."Source Type"::Customer:
                BEGIN
                    IF (SourceNo2 <> '') AND (Alarm."Source No. 2" <> '') THEN
                        Recordreference.OPEN(DATABASE::"Ship-to Address")
                    ELSE
                        Recordreference.OPEN(DATABASE::Customer);
                END;
            Alarm."Source Type"::Vendor:
                BEGIN
                    IF (SourceNo2 <> '') AND (Alarm."Source No. 2" <> '') THEN
                        Recordreference.OPEN(DATABASE::"Order Address")
                    ELSE
                        Recordreference.OPEN(DATABASE::Vendor);
                END;
            Alarm."Source Type"::"Service Item":
                Recordreference.OPEN(DATABASE::"Service Item");
            Alarm."Source Type"::Contract:
                Recordreference.OPEN(DATABASE::"Service Contract Header");
        END;
        Recordreference.SETVIEW(TempFilter + TempFilter2);
        IF Recordreference.FINDFIRST THEN
            EXIT(TRUE);
    end;

    /// <summary>
    /// CheckUnactivate()
    /// </summary>
    procedure CheckUnactivate(var Alarm: Record "Alarms_LDR")
    var
        TempLog: Record "Alarms Log_LDR";
        NewLog: Record "Alarms Log_LDR";
    begin
        // Desactiva las alarmas en proximo uso
        IF Alarm."Off on next use" THEN BEGIN
            Alarm."End Date" := TODAY;
            Alarm.MODIFY;
        END;
    end;
}