<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Crider.Master" AutoEventWireup="true" CodeBehind="Shippingdockboard.aspx.cs" Inherits="CriderDashboard.Reports.Shippingdockboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/grid.css" rel="stylesheet" />
    <script>
        $(document).ready(function () {

            $("#frmDate").datepicker({
                minDate: new Date(2017, 01, 01),
                dateFormat: 'yy-mm-dd',
               
            });

            var datevalue = $('#frmDate').val();

            if (datevalue.trim().length > 0) {

            }
            else {
                var d = new Date();
                var hr = d.getHours();
                if (hr >= 0 && hr <= 5) {

                    $('#frmDate').datepicker("setDate", -1);
                }
                else {

                    $('#frmDate').datepicker("setDate", d);
                }
            }
            GetShippingdockboard();
            GetNewArrivedList();
            GetNewInDoorList();
            GetNewStatusList()

        });
        function GetShippingdockboard() {
            var title = "Fresh Shipping Incoming Loads";
            var obj1 = {};
            obj1.Id = 0;
            obj1.FrmDate = $('#frmDate').val();
            obj1.ToDate = $('#frmDate').val();
            obj1.Supplier = '0';
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetShippingdockboard",
                data: "{objRequest:" + JSON.stringify(obj1) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (data) {
                    table = $('#Canning').DataTable({
                         dom: 'Bfrtip',
                        buttons: [
                            { extend: 'copyHtml5', footer: true, title: title, exportOptions: {
                                    columns: [0, 1, 2, 3, 4, 5,6,7,8,9]
                                }
                            },
                            { extend: 'excelHtml5', footer: true, title: title, exportOptions: {
                                    columns: [0, 1, 2, 3, 4, 5,6,7,8,9]
                                }
                            },
                            { extend: 'csvHtml5', footer: true, title: title, exportOptions: {
                                    columns: [0, 1, 2, 3, 4, 5,6,7,8,9]
                                }
                            },
                            { extend: 'pdfHtml5', title: title, exportOptions: {
                                    columns: [0, 1, 2, 3, 4, 5,6,7,8,9]
                                }},
                             { extend: 'print', title:title,exportOptions: {
                                    columns: [0, 1, 2, 3, 4, 5,6,7,8,9]
                                }}
                        ],
                        // "iDisplayLength": 4,
                        //"scrollX": true,
                       
                        //"scrollCollapse": true,

                        responsive: true,
                        "paging": false,
                        destroy: true,
                        data: data.d,
                        autowidth: false,
                        "aaSorting": [],
                        "columns": [
                            { 'data': 'Status' },
                            { 'data': 'ScheduledTime' },
                             { 'data': 'ArrivalTime' },
                            { 'data': 'Arrived' },
                            { 'data': 'InDoor' },
                            { 'data': 'Po' },
                            { 'data': 'ProductCode' },
                            { 'data': 'Supplier' },
                            { 'data': 'Destination' },
                            { 'data': 'Notes' },
                            //{
                            //    "className": 'details-control',
                            //    "data": 'Dtmin'

                            //},
                            {
                                'data': 'Id',
                                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                                     $(nTd).html("<a id=\"edit_" + iRow + "\" class=\"btnedit\" style=\"display:block;\" title=\"Edit\" onclick=\"EditData(" + iRow + "," + oData.Id + ")\"></a>&nbsp;  <a id=\"delete_" + iRow + "\" style=\"display:block;margin-top: -2px;margin-left: 1px;\" title=\"Delete\" class=\"btndelpm\" onclick='deleteCanning(" + oData.Id + ")'></a>&nbsp;  <a id=\"update_" + iRow + "\" style=\"display:none;margin-top: -31%;padding-top: 39%;\" class=\"btnupdate\" title=\"Update\" onclick=\"UpdateData(" + iRow + "," + oData.Id + ")\"></a>&nbsp;  <a id=\"cancel_" + iRow + "\" style=\"display:none;margin-top: -72.7%;margin-left: 38.2%;padding-bottom: 12%;\" title=\"Cancel\" class=\"btncancelpm\" onclick=\"CancelData(" + iRow + ")\"></a> ");
                                   
                                    //$(nTd).html("<a id=\"edit_" + iRow + "\" class=\"btnedit\" style=\"display:block;\" title=\"Edit\" onclick=\"EditData(" + iRow + "," + oData.Id + ")\"></a>&nbsp;  <a id=\"delete_" + iRow + "\" style=\"display:block;margin-top: -2%;margin-left: 1%;\" title=\"Delete\" class=\"btndelpm\" onclick='deleteCanning(" + oData.Id + ")'></a>&nbsp;  <a id=\"update_" + iRow + "\" style=\"display:none;padding-top: 31px;margin-top: -34%;\" class=\"btnupdate\" title=\"Update\" onclick=\"UpdateData(" + iRow + "," + oData.Id + ")\"></a>&nbsp;  <a id=\"cancel_" + iRow + "\" style=\"display:none;margin-top: -4.7%;margin-left: 2%;padding-top: 16px;\" title=\"Cancel\" class=\"btncancelpm\" onclick=\"CancelData(" + iRow + ")\"></a> ");
                                }
                            },

                        ],
                        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                            $(nRow).find('td:eq(0)').css('font-size', '150%');
                            $(nRow).find('td:eq(1)').css('font-size', '150%');
                            $(nRow).find('td:eq(2)').css('font-size', '150%');
                            $(nRow).find('td:eq(3)').css('font-size', '150%');
                            $(nRow).find('td:eq(4)').css('font-size', '150%');
                            $(nRow).find('td:eq(5)').css('font-size', '150%');
                            $(nRow).find('td:eq(6)').css('font-size', '150%');
                            $(nRow).find('td:eq(7)').css('font-size', '150%');
                            $(nRow).find('td:eq(8)').css('font-size', '150%');
                            $(nRow).find('td:eq(9)').css('font-size', '150%');
                            if (aData.Status == 'On Time') {
                                $(nRow).find('td:eq(0)').css('background-color', 'limegreen');
                                $(nRow).find('td:eq(0)').css('color', 'white');
                                $(nRow).find('td:eq(0)').css('font-weight', 'bold');
                            }

                            if (aData.Status == 'Late') {
                                $(nRow).find('td:eq(0)').css('background-color', 'red');
                                $(nRow).find('td:eq(0)').css('color', 'white');
                                $(nRow).find('td:eq(0)').css('font-weight', 'bold');
                            }
                            if (aData.Status == 'Done') {
                                $(nRow).find('td:eq(0)').css('background-color', 'black');
                                $(nRow).find('td:eq(0)').css('color', 'white');
                                $(nRow).find('td:eq(0)').css('font-weight', 'bold');

                            }
                            if (aData.Arrived == 'Yes/Live') {
                                $(nRow).find('td:eq(3)').css('background-color', 'limegreen');
                                $(nRow).find('td:eq(3)').css('color', 'white');
                                $(nRow).find('td:eq(3)').css('font-weight', 'bold');
                            }
                             if (aData.Arrived == 'Yes/Drop') {
                                $(nRow).find('td:eq(3)').css('background-color', 'limegreen');
                                $(nRow).find('td:eq(3)').css('color', 'white');
                                $(nRow).find('td:eq(3)').css('font-weight', 'bold');
                            }
                            if (aData.Arrived == 'No') {
                                $(nRow).find('td:eq(3)').css('background-color', 'red');
                                $(nRow).find('td:eq(3)').css('color', 'white');
                                $(nRow).find('td:eq(3)').css('font-weight', 'bold');
                            }
                            if (aData.InDoor == 'No') {
                                $(nRow).find('td:eq(4)').css('background-color', 'red');
                                $(nRow).find('td:eq(4)').css('color', 'white');
                                $(nRow).find('td:eq(4)').css('font-weight', 'bold');
                            }
                            if (aData.InDoor == 'Done') {
                                $(nRow).find('td:eq(4)').css('background-color', 'black');
                                $(nRow).find('td:eq(4)').css('color', 'white');
                                $(nRow).find('td:eq(4)').css('font-weight', 'bold');
                            }
                            if (aData.InDoor != 'Done' && aData.InDoor != 'No')
                            {
                                $(nRow).find('td:eq(4)').css('background-color', 'limegreen');
                                $(nRow).find('td:eq(4)').css('color', 'white');
                                $(nRow).find('td:eq(4)').css('font-weight', 'bold');
                            }


                        },

                        columnDefs: [
                            {
                                'targets': [0, 1, 2, 3, 4, 5, 6, 7, 8,9],
                                class: 'col-2',
                                'createdCell': function (td, cellData, rowData, row, col) {
                                    if (col == 0)
                                        $(td).attr('id', 'Status_' + row);
                                    //if (col == 1)
                                    //    $(td).attr('id', 'SDate_' + row);
                                    if (col == 1)
                                        $(td).attr('id', 'STime_' + row);
                                    if (col == 2)
                                        $(td).attr('id', 'ATime_' + row);
                                    if (col == 3)
                                        $(td).attr('id', 'Arrived_' + row);
                                    if (col == 4)
                                        $(td).attr('id', 'InDoor_' + row);
                                    if (col == 5)
                                        $(td).attr('id', 'Po_' + row);
                                    if (col == 6)
                                        $(td).attr('id', 'PCode_' + row);
                                    if (col == 7)
                                        $(td).attr('id', 'Supplier_' + row);
                                    if (col == 8)
                                        $(td).attr('id', 'Destination_' + row);
                                    if (col == 9)
                                        $(td).attr('id', 'Notes_' + row);
                                }

                            },

                        ]
                    });
                },
                failure: function (response) {
                },
                error: function (response) {
                }
            });
        }

        function EditData(no, Id) {
            document.getElementById("edit_" + no).style.display = "none";
            document.getElementById("delete_" + no).style.display = "none";
            document.getElementById("update_" + no).style.display = "block";
            document.getElementById("cancel_" + no).style.display = "block";
            var status = document.getElementById("Status_" + no);
            //var sdate = document.getElementById("SDate_" + no);
            var stime = document.getElementById("STime_" + no);
             var atime = document.getElementById("ATime_" + no);
            var arrived = document.getElementById("Arrived_" + no);
            var indoor = document.getElementById("InDoor_" + no);
            var po = document.getElementById("Po_" + no);
            var pcode = document.getElementById("PCode_" + no);
            var supplier = document.getElementById("Supplier_" + no);
            var destination = document.getElementById("Destination_" + no);
            var notes = document.getElementById("Notes_" + no);

            var statusRow = status.innerHTML;
            //var sdateRow = sdate.innerHTML;
            var stimeRow = stime.innerHTML;
               var atimeRow = atime.innerHTML;
            var arrivedRow = arrived.innerHTML;
            var indoorRow = indoor.innerHTML;
            var poRow = po.innerHTML;
            var pcodeRow = pcode.innerHTML;
            var supplierRow = supplier.innerHTML;
            var destinationRow = destination.innerHTML;
            var notesRow = notes.innerHTML;
            //sdate.innerHTML = "<input type='text' id='txtsdate_" + no + "' value='" + sdateRow + "' style='width: 75px;'>";
            stime.innerHTML = "<input type='text' id='txtstime_" + no + "' value='" + stimeRow + "' style='width: 75px;'>";
              atime.innerHTML = "<input type='text' id='txtatime_" + no + "' value='" + atimeRow + "' style='width: 75px;'>";
            po.innerHTML = "<input type='text' id='txtpo_" + no + "' value='" + poRow + "' style='width: 75px;'>";
            pcode.innerHTML = "<input type='text' id='txtpcode_" + no + "' value='" + pcodeRow + "' style='width: 75px;'>";
            supplier.innerHTML = "<input type='text' id='txtsupplier_" + no + "' value='" + supplierRow + "' style='width: 75px;'>";
            destination.innerHTML = "<input type='text' id='txtdestination_" + no + "' value='" + destinationRow + "' style='width: 75px;'>";
            notes.innerHTML = "<input type='text' id='txtnotes_" + no + "' value='" + notesRow + "' style='width: 75px;'>";
            var dropdownname = "ddlStatus_" + no + "";
            status.innerHTML = "<select name=" + dropdownname + " id=" + dropdownname + " class='form-control' style='max-width:90px;'></select>";
            GetStatusList(no, statusRow);
            var dropdownname1 = "ddlArrived_" + no + "";
            arrived.innerHTML = "<select name=" + dropdownname1 + " id=" + dropdownname1 + " class='form-control' style='max-width:90px;'></select>";
            GetArrivedList(no, arrivedRow);
            var dropdownname2 = "ddlIndoor_" + no + "";
            indoor.innerHTML = "<select name=" + dropdownname2 + " id=" + dropdownname2 + " class='form-control' style='max-width:90px;'></select>";
            GetInDoorList(no, indoorRow);
            $('#Status_' + no).css('background-color', 'white');
            $('#Arrived_' + no).css('background-color', 'white');
            $('#InDoor_' + no).css('background-color', 'white');
            $('#Status_' + no).css('font-weight', 'normal');
            $('#Arrived_' + no).css('font-weight', 'normal');
            $('#InDoor_' + no).css('font-weight', 'normal');


        }

        function UpdateData(no, Id) {
            var status = $("#ddlStatus_" + no + " option:selected").text();
            //var sdate = $("#txtsdate_" + no).val();
            var stime = $("#txtstime_" + no).val();
             var atime = $("#txtatime_" + no).val();
            var arrived = $("#ddlArrived_" + no + " option:selected").text();
            var indoor = $("#ddlIndoor_" + no + " option:selected").text();
            var po = $("#txtpo_" + no).val();
            var pcode = $("#txtpcode_" + no).val();
            var supplier = $("#txtsupplier_" + no).val();
            var destination = $("#txtdestination_" + no).val();
            var notes = $("#txtnotes_" + no).val();
            ShippingdockboardValidation(status, stime,atime, arrived, indoor, po, pcode, supplier, destination, notes, Id);
        }
        function CancelData(no) {
            document.getElementById("edit_" + no).style.display = "block";
            document.getElementById("delete_" + no).style.display = "block";
            document.getElementById("update_" + no).style.display = "none";
            document.getElementById("cancel_" + no).style.display = "none";
            var status = $("#ddlStatus_" + no + " option:selected").text();
            //var sdate = $("#txtsdate_" + no).val();
            var stime = $("#txtstime_" + no).val();
              var atime = $("#txtatime_" + no).val();
            var arrived = $("#ddlArrived_" + no + " option:selected").text();
            var indoor = $("#ddlIndoor_" + no + " option:selected").text();
            var po = $("#txtpo_" + no).val();
            var pcode = $("#txtpcode_" + no).val();
            var supplier = $("#txtsupplier_" + no).val();
            var destination = $("#txtdestination_" + no).val();
            var notes = $("#txtnotes_" + no).val();
            document.getElementById("Status_" + no).innerHTML = status;
            // document.getElementById("SDate_" + no).innerHTML = sdate;
            document.getElementById("STime_" + no).innerHTML = stime;
                document.getElementById("ATime_" + no).innerHTML = atime;
            document.getElementById("Arrived_" + no).innerHTML = arrived;
            document.getElementById("InDoor_" + no).innerHTML = indoor;
            document.getElementById("Po_" + no).innerHTML = po;
            document.getElementById("PCode_" + no).innerHTML = pcode;
            document.getElementById("Supplier_" + no).innerHTML = supplier;
            document.getElementById("Destination_" + no).innerHTML = destination;
            document.getElementById("Notes_" + no).innerHTML = notes;
            GetShippingdockboard();
        }

        function GetInDoorList(idData, selvalue) {
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetInDoordata",
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    var ddlselected = selvalue;
                    var Result = response.d;
                    $("#ddlIndoor_" + idData + "").empty();
                    for (var i in Result) {

                        $("#ddlIndoor_" + idData + "").append('<option value=' + Result[i].Id + '>' + Result[i].InDoor + '</option>');
                    }
                    if (ddlselected.length > 0) {
                        for (var j in Result) {
                            if (Result[j].InDoor == ddlselected) {
                                $("#ddlIndoor_" + idData + "").val(Result[j].Id);
                                return false;
                            }
                        }
                    }
                    $("#ddlIndoor_" + idData + "").trigger("liszt:updated");
                },
                error: function (err) {

                }
            });

        }
        function searchData() {
            GetShippingdockboard();
        }
        function GetArrivedList(idData, selvalue) {
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetArriveddata",
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    var ddlselected = selvalue;
                    var Result = response.d;
                    $("#ddlArrived_" + idData + "").empty();
                    for (var i in Result) {
                        $("#ddlArrived_" + idData + "").append('<option value=' + Result[i].Id + '>' + Result[i].Arrived + '</option>');
                    }
                    if (ddlselected.length > 0) {
                        for (var j in Result) {
                            if (Result[j].Arrived == ddlselected) {
                                $("#ddlArrived_" + idData + "").val(Result[j].Id);
                                return false;
                            }
                        }
                    }
                    $("#ddlArrived_" + idData + "").trigger("liszt:updated");
                },
                error: function (err) {
                }
            });
        }
        function GetStatusList(idData, selvalue) {
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetStatusData",
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    var ddlselected = selvalue;
                    var Result = response.d;
                    $("#ddlStatus_" + idData + "").empty();
                    for (var i in Result) {
                        $("#ddlStatus_" + idData + "").append('<option value=' + Result[i].Id + '>' + Result[i].Status + '</option>');
                    }
                    if (ddlselected.length > 0) {
                        for (var j in Result) {
                            if (Result[j].Status == ddlselected) {
                                $("#ddlStatus_" + idData + "").val(Result[j].Id);
                                return false;
                            }
                        }
                    }
                    $("#ddlStatus_" + idData + "").trigger("liszt:updated");
                },
                error: function (err) {
                }
            });

        }
        function deleteCanning(Id) {
            if (confirm('Are you sure you want to delete this?')) {
                var obj1 = {};
                obj1.Id = Id;
                $.ajax({
                    type: "POST",
                    url: "Shippingdockboard.aspx/DeleteShippingdockboard",
                    data: "{objRequest:" + JSON.stringify(obj1) + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //location.reload();
                          GetShippingdockboard();
                    },
                    failure: function (response) {

                    },
                    error: function (response) {

                    }
                });
            }
        }

        function GetNewStatusList() {
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetStatusData",
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    var Result = response.d;
                    $("#newStatus").empty();
                    $('#newStatus').append('<option value="0">Select Status</option>');
                    for (var i in Result) {
                        $("#newStatus").append('<option value=' + Result[i].Id + '>' + Result[i].Status + '</option>');
                    }
                    $("#newStatus").trigger("liszt:updated");
                },
                error: function (err) {
                }
            });

        }

        function GetNewArrivedList() {
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetArriveddata",
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    var Result = response.d;
                    $("#newArrived").empty();
                    $('#newArrived').append('<option value="0">Select Arrived</option>');
                    for (var i in Result) {
                        $("#newArrived").append('<option value=' + Result[i].Id + '>' + Result[i].Arrived + '</option>');
                    }
                    $("#newArrived").trigger("liszt:updated");
                },
                error: function (err) {
                }
            });

        }


        function GetNewInDoorList() {
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/GetInDoordata",
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (response) {
                    var Result = response.d;
                    $("#newInDoor").empty();
                    $('#newInDoor').append('<option value="0">Select InDoor</option>');
                    for (var i in Result) {
                        $("#newInDoor").append('<option value=' + Result[i].Id + '>' + Result[i].InDoor + '</option>');
                    }
                    $("#newInDoor").trigger("liszt:updated");
                },
                error: function (err) {
                }
            });

        }
        function AddData() {
            var status = $("#newStatus option:selected").text();
            //var sdate = document.getElementById("newSDate").value;
            var stime = document.getElementById("newSTime").value;
              var atime = document.getElementById("newATime").value;
            var arrived = $("#newArrived option:selected").text();
            var indoor = $("#newInDoor option:selected").text();
            var po = document.getElementById("newPo").value;
            var pcode = document.getElementById("newPCode").value;
            var supplier = document.getElementById("newSupplier").value;
            var destination = document.getElementById("newDestination").value;
            var notes = document.getElementById("newNotes").value;
            var Id = 0;
            ShippingdockboardValidation(status, stime, atime,arrived, indoor, po, pcode, supplier, destination, notes, Id);
        }
        function ShippingdockboardValidation(status, stime, atime, arrived, indoor, po, pcode, supplier, destination, notes, Id) {
          
            var count = 0;
            var message = "";
            if (status == "0") {
                count = 1;
                message += "Please select the status\n";
            }
            if ($('#frmDate').val() == "") {
                count = 1;
                message += "Please enter the scheduled date\n";
            }
            //if (stime == "") {
            //    count = 1;
            //    message += "Please enter the scheduled time\n";
            //}

             var startvalid = (stime.search(/^\d{2}:\d{2}$/) != -1) &&
            (stime.substr(0,2) >= 0 && stime.substr(0,2) < 24) &&
            (stime.substr(3,2) >= 0 && stime.substr(3,2) <= 59) ;
            if (!startvalid) {
                count = 1;
                message += "Scheduled Time is not a proper format. Please check and try again\n";
            }
            
            if (arrived == "0") {
                count = 1;
                message += "Please select the arrived\n";
            }
            if (indoor == "0") {
                count = 1;
                message += "Please select the indoor\n";
            }
            if (po == "") {
                count = 1;
                message += "Please enter the po#\n";
            }
            if (pcode == "") {
                count = 1;
                message += "Please enter the product code\n";
            }
            if (supplier == "") {
                count = 1;
                message += "Please enter the supplier\n";
            }
            if (destination == "") {
                count = 1;
                message += "Please enter the destination\n";
            }
            //if (notes == "") {
            //    count = 1;
            //    message += "Please enter the notes\n";
            //}
            if (count == 1) {
                lblErr.innerHTML = message;
                alert(message);
            }
            else {
                SaveData(status, stime,atime, arrived, indoor, po, pcode, supplier, destination, notes, Id);

            }
        }

        function SaveData(status, stime,atime, arrived, indoor, po, pcode, supplier, destination, notes, Id) {
            var obj1 = {};
            obj1.Id = Id;
            obj1.Status = $.trim(status);
            obj1.ScheduledDate = $.trim($('#frmDate').val());
            obj1.ScheduledTime = $.trim(stime);
            obj1.ArrivalTime = $.trim(atime);
            obj1.Arrived = $.trim(arrived);
            obj1.InDoor = $.trim(indoor);
            obj1.Po = $.trim(po);
            obj1.ProductCode = $.trim(pcode);
            obj1.Supplier = $.trim(supplier);
            obj1.Destination = $.trim(destination);
            obj1.Notes = $.trim(notes);
            $.ajax({
                type: "POST",
                url: "Shippingdockboard.aspx/InsertShippingdockboard",
                data: "{objRequest:" + JSON.stringify(obj1) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    
                        $("#newStatus").val("0");
                        //$("#newSDate").val("");
                    $("#newSTime").val("");
                      $("#newATime").val("");
                        $("#newArrived").val("0");
                        $("#newInDoor").val("0");
                        $("#newPo").val("");
                        $("#newPCode").val("");
                        $("#newSupplier").val("");
                        $("#newDestination").val("");
                        $("#newNotes").val("");
                        GetShippingdockboard();
                    
                    
                },
                error: function (err) {
                    alert('ERROR: Issue while saving shipping dock board.Please try again.');
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row">

            
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
            <p>
                <input type="text" class="form-control" id="frmDate" name="frmDate" placeholder="From Date"
                    runat="server" clientidmode="Static" readonly="readonly" style="background-color: white;" />
            </p>
        </div>

        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">


            <button type="button" id="btnSearch" class="btn btn-large btn-info" onclick="searchData()">Search</button>
        </div>
    </div>
  
    <br />
    <div class="row clearfix">
        <div class="col-lg-12 col-md-12 col-sm-6 col-xs-12">
            <div class="card">
                <div class="header bg-cyan">
                    <h2>Shipping Dockboard Report
                    </h2>

                </div>
                   <div class="alert alert-success" style="display: none;" id="divSuccess" runat="server">
                    <a class="close" data-dismiss="alert">×</a> <strong>Success!</strong>&nbsp;
                        <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                </div>
                <div id="divError" class="alert alert-danger" style="display: none;">
                    <a class="close" data-dismiss="alert">×</a><strong>Error!</strong>&nbsp;
                        <asp:Label ID="lblErr" runat="server" ClientIDMode="Static"></asp:Label>
                </div>

                <div class="body">
                    <div class="form">

                        <fieldset style="text-align: center;">
                            <div class="row clearfix">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <div class="card">
                                        <div class="body">
                                            <table id="Canning" class="table table-striped table-bordered" style="background-color: White; width: 100%; border-color: #CCCCCC; border-width: 1px; border-collapse: collapse;">
                                                 <thead style="color: white; background-color: lightslategray;">
                                    <tr>
                                        <th style="text-align: center;font-size:150%;">Status</th>
                                        <%--<th style="text-align: center;">Scheduled Date</th>--%>
                                        <th style="text-align: center;font-size:150%;">Scheduled Time</th>
                                        <th style="text-align: center;font-size:150%;">Arrival Time</th>
                                        <th style="text-align: center;font-size:150%;">Arrived</th>
                                        <th style="text-align: center;font-size:150%;">InDoor</th>
                                        <th style="text-align: center;font-size:150%;">PO#</th>
                                        <th style="text-align: center;font-size:150%;">ProductCode</th>
                                        <th style="text-align: center;font-size:150%;">Supplier</th>
                                        <th style="text-align: center;font-size:150%;">Destination</th>
                                        <th style="text-align: center;font-size:150%;">Notes</th>
                                        <th style="text-align: center;font-size:150%;">Action</th>
                                    </tr>
                                </thead>
                                <tfoot align="right" style="background-color: #006699; color: white">
                                   
                                    <tr>
                                        <th style="text-align: center;">
                                            <select name="newStatus" id="newStatus" class='form-control' style='max-width: 60px;font-size:150%;'></select></th>
                                        <th style="text-align: center;">
                                            <input type="text" id="newSTime" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                          <th style="text-align: center;">
                                            <input type="text" id="newATime" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                        <th style="text-align: center;">
                                            <select name="newArrived" id="newArrived" class='form-control' style='max-width: 90px;font-size:150%;'></select></th>
                                        <th style="text-align: center;">
                                            <select name="newInDoor" id="newInDoor" class='form-control' style='max-width: 90px;font-size:150%;'></select></th>
                                        <th style="text-align: center;">
                                            <input type="text" id="newPo" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                        <th style="text-align: center;">
                                            <input type="text" id="newPCode" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                        <th style="text-align: center;">
                                            <input type="text" id="newSupplier" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                        <th style="text-align: center;">
                                            <input type="text" id="newDestination" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                        <th style="text-align: center;">
                                            <input type="text" id="newNotes" class="form-control" value="" style="width: 75px;font-size:150%;"></th>
                                        <th style="text-align: center;"><a onclick="AddData()" title="Add" id="newadd">
                                            <img src="../img/save25.png" /></a></th>
                                    </tr>
                                </tfoot>
                                            </table>
                                            <%--    </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- #END# Exportable Table -->
                        </fieldset>

                    </div>

                </div>
            </div>
        </div>
      <input type="hidden" name="hsessionvalue" clientidmode="Static" id="hsessionvalue" runat="server" />
    </div>


</asp:Content>
