<%@ Page language="C#"%>
<!--
Copyright 2002-2011 Corey Trager
Distributed under the terms of the GNU General Public License
-->
<!-- #include file = "inc.aspx" -->

<script language="C#" runat="server">

String sql;

Security security;

void Page_Init (object sender, EventArgs e) {ViewStateUserKey = Session.SessionID;}

///////////////////////////////////////////////////////////////////////
void Page_Load(Object sender, EventArgs e)
{

	Util.do_not_cache(Response);
	
	security = new Security();
	security.check_security( HttpContext.Current, Security.MUST_BE_ADMIN);

	if (IsPostBack)
	{
		// do delete here
		sql = @"delete priorities where pr_id = $1";
        sql = sql.Replace("$1", Util.sanitize_integer(row_id.Value));
		btnet.DbUtil.execute_nonquery(sql);
		Server.Transfer ("priorities.aspx");
	}
	else
	{

		titl.InnerText = Util.get_setting("AppTitle","TDSS Bugs Tracker") + " - "
			+ "delete priority";

		string id = Util.sanitize_integer(Request["id"]);


		sql = @"declare @cnt int
			select @cnt = count(1) from bugs where bg_priority = $1
			select pr_name, @cnt [cnt] from priorities where pr_id = $1";
		sql = sql.Replace("$1", id);

		DataRow dr = btnet.DbUtil.get_datarow(sql);

		if ((int) dr["cnt"] > 0)
		{
			Response.Write ("You can't delete priority \""
				+ Convert.ToString(dr["pr_name"])
				+ "\" because some bugs still reference it.");
			Response.End();
		}
		else
		{

			confirm_href.InnerText = "confirm delete of \""
				+ Convert.ToString(dr["pr_name"])
				+ "\"";

			row_id.Value = id;

		}

	}

}

</script>

<html>
<head>
<title id="titl" runat="server">btnet delete priority</title>
<link rel="StyleSheet" href="btnet.css" type="text/css">
</head>
<body>
<% security.write_menu(Response, "admin"); %>
<p>
<div class=align>
<p>&nbsp</p>
<a href=priorities.aspx>back to priorities</a>

<p>or<p>

<script>
function submit_form()
{
    var frm = document.getElementById("frm");
    frm.submit();
    return true;
}

</script>
<form runat="server" id="frm">
<a id="confirm_href" runat="server" href="javascript: submit_form()"></a>
<input type="hidden" id="row_id" runat="server">
</form>

</div>
<% Response.Write(Application["custom_footer"]); %></body>
</html>


