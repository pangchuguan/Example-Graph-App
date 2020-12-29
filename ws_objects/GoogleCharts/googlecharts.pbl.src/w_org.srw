$PBExportHeader$w_org.srw
forward
global type w_org from w_chart_base
end type
type dw_org from datawindow within w_org
end type
type st_2 from statictext within w_org
end type
type dw_manager from datawindow within w_org
end type
type dw_orgsales from datawindow within w_org
end type
end forward

global type w_org from w_chart_base
string tag = "org"
integer width = 4507
integer height = 2004
boolean clientedge = true
dw_org dw_org
st_2 st_2
dw_manager dw_manager
dw_orgsales dw_orgsales
end type
global w_org w_org

type variables
Boolean ib_flag = True
end variables

forward prototypes
public subroutine wf_apply ()
public function string wf_createdata (datawindow as_dw1, datawindow as_dw2)
end prototypes

public subroutine wf_apply ();String ls_Title, ls_Data, ls_Option

//Title
ls_Title = "Company Distribution"
wb_1.of_SetTitle(ls_Title)
//Style
wb_1.of_SetStyle("org")
////Width
//wb_1.of_SetWidth(800 )
////Height
//wb_1.of_SetHeight(500)
//CreateData
ls_Data = wf_CreateData(dw_org, dw_orgsales)
//SetData
wb_1.of_SetData(ls_Data)
//CreateOption
ls_Option = wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()



end subroutine

public function string wf_createdata (datawindow as_dw1, datawindow as_dw2);Long		ll_RootArray, ll_ChildArray, ll_ChildObject, ll_ChildObject2,ll_ChildObject3, ll_i, ll_j, ll_Row, ll_flag
String		ls_Data, ls_fname, ls_lname, ls_emp_fname, ls_emp_lname, ls_emp, ls_manager
String		ls_sales_fname, ls_sales_lname, ls_sales, ls_temp
DataStore	lds_Data
JsonGenerator		ljson_Option

ljson_Option = Create JsonGenerator
ll_RootArray = ljson_Option.CreateJsonArray()

TRY
	//Data1(company and department)
	ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
	ll_ChildObject = ljson_Option.AddItemObject(ll_ChildArray)
	ljson_Option.AddItemString(ll_ChildObject, "id", "''")
	ljson_Option.AddItemString(ll_ChildObject, "label", "'Name'")
	ljson_Option.AddItemString(ll_ChildObject, "pattern", "''")
	ljson_Option.AddItemString(ll_ChildObject, "type", "'string'")
	
	ll_ChildObject2 = ljson_Option.AddItemObject(ll_ChildArray)
	ljson_Option.AddItemString(ll_ChildObject2, "id", "''")
	ljson_Option.AddItemString(ll_ChildObject2, "label", "'Name'")
	ljson_Option.AddItemString(ll_ChildObject2, "pattern", "''")
	ljson_Option.AddItemString(ll_ChildObject2, "type", "'string'")
	
	ll_ChildObject3 = ljson_Option.AddItemObject(ll_ChildArray)
	ljson_Option.AddItemString(ll_ChildObject3, "id", "''")
	ljson_Option.AddItemString(ll_ChildObject3, "label", "'Name'")
	ljson_Option.AddItemString(ll_ChildObject3, "pattern", "''")
	ljson_Option.AddItemString(ll_ChildObject3, "type", "'string'")
	
	ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
	ll_ChildObject = ljson_Option.AddItemObject(ll_ChildArray)
	ljson_Option.AddItemString(ll_ChildObject, "'v'", "'Company'")
	
	ljson_Option.AddItemString(ll_ChildObject, "'f'", "'Company<div style=~"color:red; font-style:italic~">Company</div>'")
	
	ljson_Option.AddItemString(ll_ChildArray, "''")
	ljson_Option.AddItemString(ll_ChildArray, "'The Company'")	

	
	FOR ll_i = 1 TO as_dw1.RowCount()
		
		ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
		ll_ChildObject = ljson_Option.AddItemObject(ll_ChildArray)
		ljson_Option.AddItemString(ll_ChildObject, "'v'", "'"+ wf_GetItemString( as_dw1, ll_i, 1) +"'")
		
		ljson_Option.AddItemString(ll_ChildObject, "'f'", "'"+ wf_GetItemString( as_dw1, ll_i, 1) +"<div style=~"color:red; font-style:italic~">Department</div>'")
		
		ljson_Option.AddItemString(ll_ChildArray, "'Company'")
		ljson_Option.AddItemString(ll_ChildArray, "'The Department'")
		
		ls_fname = wf_GetItemString(as_dw1, ll_i, 2)
		ls_lname = wf_GetItemString(as_dw1, ll_i, 3)
		ls_manager = ls_fname + " " + ls_lname
	
		ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
		ll_ChildObject = ljson_Option.AddItemObject(ll_ChildArray)
		ljson_Option.AddItemString(ll_ChildObject, "'v'", "'"+ ls_Manager +"'")
		ljson_Option.AddItemString(ll_ChildObject, "'f'", "'"+ ls_Manager +"<div style=~"color:red; font-style:italic~">Manger</div>'")
		ljson_Option.AddItemString(ll_ChildArray,  "'"+ wf_GetItemString( as_dw1, ll_i, 1) +"'")
		ljson_Option.AddItemString(ll_ChildArray, "'The Manager'")
		
		
		ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
		ls_emp_fname = wf_GetItemString(as_dw1, ll_i, 4)
		ls_emp_lname = wf_GetItemString(as_dw1, ll_i, 5)
		ls_emp = ls_emp_fname + " " + ls_emp_lname
		
		ljson_Option.AddItemString(ll_ChildArray, "'"+ls_emp+"'")

		ljson_Option.AddItemString(ll_ChildArray, "'"+ls_manager+"'")
		ljson_Option.AddItemString(ll_ChildArray, "'The Employee'")

	NEXT
		

	ll_flag = 0
	ls_temp =""
	FOR ll_j = 1 TO as_dw2.RowCount()
		ls_sales_fname = wf_GetItemString(as_dw2, ll_j, 1)
		ls_sales_lname = wf_GetItemString(as_dw2, ll_j, 2)
		ls_sales = ls_sales_fname + " " + ls_sales_lname
		//Counter
		IF ls_temp <> ls_sales THEN
			ls_temp = ls_sales
			ll_flag = 1
		ELSE
			ll_flag ++
		END IF
		
		IF ll_flag < 5 THEN
			ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
			ljson_Option.AddItemString(ll_ChildArray, "'"+wf_GetItemString(as_dw2, ll_j, 3)+"'")
			ljson_Option.AddItemString(ll_ChildArray, "'"+ls_sales+"'")
			ljson_Option.AddItemString(ll_ChildArray, "'Sales Order ID'")
		ELSEIF  ll_flag = 5 THEN
			ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
			ljson_Option.AddItemString(ll_ChildArray, "'"+wf_GetItemString(as_dw2, ll_j, 3)+"...'")
			ljson_Option.AddItemString(ll_ChildArray, "'"+ls_sales+"'")
			ljson_Option.AddItemString(ll_ChildArray, "'(more)...'")
		END IF
	NEXT

CATCH(throwable ex)
	Messagebox("Error", ex.getmessage())
END TRY

ls_Data = ljson_Option.GetJsonString()


RETURN ls_Data
end function

on w_org.create
int iCurrent
call super::create
this.dw_org=create dw_org
this.st_2=create st_2
this.dw_manager=create dw_manager
this.dw_orgsales=create dw_orgsales
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_org
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_manager
this.Control[iCurrent+4]=this.dw_orgsales
end on

on w_org.destroy
call super::destroy
destroy(this.dw_org)
destroy(this.st_2)
destroy(this.dw_manager)
destroy(this.dw_orgsales)
end on

event open;call super::open;
dw_org.SetTransObject(sqlca)
dw_org.Retrieve( )

dw_orgsales.SetTransObject(sqlca)
dw_orgsales.Retrieve( )


ib_flag = True

//1.waiting webbrowser init
//2.Navigation DefaultUrl
//3.event wb_1.Navigationprogressindex
end event

type wb_1 from w_chart_base`wb_1 within w_org
integer x = 37
integer y = 124
integer width = 4425
integer height = 1732
end type

event wb_1::navigationprogressindex;call super::navigationprogressindex;IF progressindex = 100 THEN
	IF ib_flag THEN 
		ib_flag = False
		wf_apply()
	END IF
END IF
end event

event wb_1::ue_clicked;call super::ue_clicked;
JsonParser lnv_JsonParser
Long 		ll_RootObject, ll_Find, ll_Find2, ll_I, ll_juge
String 	ls_Name, ls_str

lnv_JsonParser = Create JsonParser


lnv_JsonParser.LoadString(as_arg)
ll_RootObject = lnv_JsonParser.GetRootItem()
ls_Name = lnv_JsonParser.GetItemString( ll_RootObject, "name" )

of_replace(ls_Name, "...", "")


IF isNumber(ls_Name) THEN
	OpenWithParm(w_order, ls_Name)
END IF


If IsValid ( lnv_JsonParser ) Then Destroy ( lnv_JsonParser )

end event

type dw_org from datawindow within w_org
boolean visible = false
integer x = 453
integer y = 188
integer width = 2021
integer height = 1740
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_org"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_org
integer x = 2057
integer y = 24
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "WebBrowser"
boolean focusrectangle = false
end type

type dw_manager from datawindow within w_org
boolean visible = false
integer x = 311
integer y = 1300
integer width = 1339
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_org_manager"
boolean border = false
boolean livescroll = true
end type

type dw_orgsales from datawindow within w_org
boolean visible = false
integer x = 2309
integer y = 292
integer width = 1335
integer height = 1516
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_org_sales"
boolean livescroll = true
end type

