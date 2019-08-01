<link rel="shortcut icon" href="images/ab.png">
<style type="text/css">
   html { height: 100% }
::-moz-selection { background: #fe57a1; color: #fff; text-shadow: none; }
::selection { background: #fe57a1; color: #fff; text-shadow: none; }
body { background-image: radial-gradient( cover, rgba(92,100,111,1) 0%,rgba(31,35,40,1) 100%), url('http://i.minus.com/io97fW9I0NqJq.png') }
.login {
  background: #eceeee;
  border: 1px solid #42464b;
  border-radius: 6px;
  height: 257px;
  margin: 20px auto 0;
  width: 298px;
}
.login h1 {
  background-image: linear-gradient(top, #f1f3f3, #d4dae0);
  border-bottom: 1px solid #a6abaf;
  border-radius: 6px 6px 0 0;
  box-sizing: border-box;
  color: #727678;
  display: block;
  height: 43px;
  font: 600 14px/1 'Open Sans', sans-serif;
  padding-top: 14px;
  margin: 0;
  text-align: center;
  text-shadow: 0 -1px 0 rgba(0,0,0,0.2), 0 1px 0 #fff;
}
 input[type="text"] {
  background: url('http://i.minus.com/ibhqW9Buanohx2.png') center left no-repeat, linear-gradient(top, #d6d7d7, #dee0e0);
  border: 1px solid #a1a3a3;
  border-radius: 4px;
  box-shadow: 0 1px #fff;
  box-sizing: border-box;
  color: #696969;
  height: 39px;
  margin: 31px 0 0 29px;
  padding-left: 11px;
  transition: box-shadow 0.3s;
  width: 240px;
}
input[type="password"]
{
    border: 1px solid #a1a3a3;
    border-radius: 4px;
    box-shadow: 0 1px #fff;
    box-sizing: border-box;
    color: #696969;
    height: 39px;
    margin: 31px 0 0 29px;
    padding-left: 11px;
    transition: box-shadow 0.3s;
    width: 240px;
   
}
 input[type="text"]:focus {
  box-shadow: 0 0 4px 1px rgba(55, 166, 155, 0.3);
  outline: 0;
}
input[type="password"]:focus
{
  box-shadow: 0 0 4px 1px rgba(55, 166, 155, 0.3);
  outline: 0;
}
.show-password {
  display: block;
  height: 16px;
  margin: 26px 0 0 28px;
  width: 87px;
}
input[type="checkbox"] {
  cursor: pointer;
  height: 16px;
  opacity: 0;
  position: relative;
  width: 64px;
}
input[type="checkbox"]:checked {
  left: 29px;
  width: 58px;
}
.toggle {
  background: url(http://i.minus.com/ibitS19pe8PVX6.png) no-repeat;
  display: block;
  height: 16px;
  margin-top: -20px;
  width: 87px;
  z-index: -1;
}
input[type="checkbox"]:checked + .toggle { background-position: 0 -16px }
.forgot {
  color: #7f7f7f;
  display: inline-block;
  float: right;
  font: 12px/1 sans-serif;
  left: -19px;
  position: relative;
  text-decoration: none;
  top: 5px;
  transition: color .4s;
}
.forgot:hover { color: #3b3b3b }
input[type="submit"] {
  width:240px;
  height:35px;
  display:block;
  font-family:Arial, "Helvetica", sans-serif;
  font-size:16px;
  font-weight:bold;
  color:#fff;
  text-decoration:none;
  text-transform:uppercase;
  text-align:center;
  /*text-shadow:1px 1px 0px #37a69b;*/
  padding-top:6px;
  margin: 29px 0 0 29px;
  position:relative;
  cursor:pointer;
  border: none;  
  background-color: #37a69b;
  background-image: linear-gradient(top,#3db0a6,#3111);
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  border-bottom-right-radius: 5px;
  border-bottom-left-radius:5px;
  box-shadow: inset 0px 1px 0px #2ab7ec, 0px 5px 0px 0px #497a78, 0px 10px 5px #999;
}

/*.shadow {
  background: #000;
  border-radius: 12px 12px 4px 4px;
  box-shadow: 0 0 20px 10px #000;
  height: 12px;
  margin: 30px auto;
  opacity: 0.2;
  width: 270px;
}*/

input[type="submit"]:active {
  top:3px;
  box-shadow: inset 0px 1px 0px #2ab7ec, 0px 2px 0px 0px #31524d, 0px 5px 3px #999;
}
/*.body{
	position: absolute;
	top: -20px;
	left: -20px;
	right: -40px;
	bottom: -40px;
	width: auto;
	height: auto;
	background-image: url(c:/Users/Manmathan/Desktop/Untitled.png) !important;
	background-size: cover;
	-webkit-filter: blur(50px);
	z-index: 0;
}*/

</style>
<%@ Page language="C#" validateRequest="false"%>
<%@ Import Namespace="System.Data.SqlClient" %><!--
Copyright 2002-2011 Corey Trager
Distributed under the terms of the GNU General Public License
--><!-- #include file = "inc.aspx" --><script language="C#" runat="server">

string sql;

///////////////////////////////////////////////////////////////////////
void Page_Load(Object sender, EventArgs e)
{

	Util.set_context(HttpContext.Current);

	Util.do_not_cache(Response);

	titl.InnerText = Util.get_setting("AppTitle","TDSS Bugs Tracker") + " - "
		+ "logon";

    msg.InnerText = "";

	// see if the connection string works
	try
	{
		// Intentionally getting an extra connection here so that we fall into the right "catch"
		TDSS.DataAccess conn = btnet.DbUtil.get_sqlconnection();
        //conn.Close();

		try
		{
			btnet.DbUtil.execute_nonquery("select count(1) from users");

		}
		catch (SqlException e1)
		{
			Util.write_to_log (e1.Message);
			Util.write_to_log (Util.get_setting("ConnectionString","?"));
            msg.InnerHtml = "Unable to find \"bugs\" table.<br>"
            + "Click to <a href=install.aspx>setup database tables</a>";
		}

	}
	catch (SqlException e2)
	{
        msg.InnerHtml = "Unable to connect.<br>"
        + e2.Message + "<br>"
        + "Check Web.config file \"ConnectionString\" setting.<br>"
        + "Check also README.html<br>"
        + "Check also <a href=http://sourceforge.net/projects/btnet/forums/forum/226938>Help Forum</a> on Sourceforge.";
	}

	// Get authentication mode
	string auth_mode = Util.get_setting("WindowsAuthentication","0");
	HttpCookie username_cookie = Request.Cookies["user"];
	string previous_auth_mode = "0";
	if (username_cookie!=null) {
		previous_auth_mode = username_cookie["NTLM"];
	}

	// If an error occured, then force the authentication to manual
	if (Request.QueryString["msg"] == null)
	{
		// If windows authentication only, then redirect
		if (auth_mode == "1")
		{
			btnet.Util.redirect("loginNT.aspx", Request, Response);
		}

		// If previous login was with windows authentication, then try it again
    	if ( previous_auth_mode == "1" && auth_mode == "2" )
    	{
		    Response.Cookies["user"]["name"] = "";
			Response.Cookies["user"]["NTLM"] = "0";
			btnet.Util.redirect("loginNT.aspx", Request, Response);
		}
	}
	else
	{
		if (Request.QueryString["msg"] != "logged off")
		{
            msg.InnerHtml = "Error during windows authentication:<br>"
                + HttpUtility.HtmlEncode(Request.QueryString["msg"]);
		}
	}


	// fill in the username first time in
	if (!IsPostBack)
	{
		if ( previous_auth_mode == "0" )
		{
			if ((Request.QueryString["user"] == null) || (Request.QueryString["password"]  == null))
			{
				//	User name and password are not on the querystring.

				if (username_cookie != null)
				{
					//	Set the user name from the last logon.

				user.Value = username_cookie["name"];
				}
			}
			else
			{
				//	User name and password have been passed on the querystring.

                user.Value = Request.QueryString["user"];
                pw.Value = Request.QueryString["password"];

				//on_logon();
			}
		}
	}
	else
	{
		on_logon();
	}

}

///////////////////////////////////////////////////////////////////////
void on_logon()
{

	string auth_mode = Util.get_setting("WindowsAuthentication","0");
	if ( auth_mode != "0" ) {
        if (user.Value.Trim() == "")
        {
			btnet.Util.redirect("loginNT.aspx", Request, Response);
		}
	}

    bool authenticated = btnet.Authenticate.check_password(user.Value, pw.Value);

    if (authenticated)
    {
        sql = "select us_id from users where us_username = N'$us'";
        sql = sql.Replace("$us", user.Value.Replace("'", "''"));
    	DataRow dr = btnet.DbUtil.get_datarow(sql);
        if (dr != null)
        {
            int us_id = (int)dr["us_id"];

            btnet.Security.create_session(
            	Request,
            	Response,
                us_id,
                user.Value,
                "0");

            btnet.Util.redirect(Request, Response);
        }
        else
        {
           
            // How could this happen?  If someday the authentication
            // method uses, say LDAP, then check_password could return
            // true, even though there's no user in the database";
           // msg.InnerText = "User not found in database";
        }
	}
	else
	{
		msg.InnerText = "Invalid User or Password.";
       
       
	}

}

</script><html><head><title id="titl" runat="server">TDSSINC</title>
<link rel="StyleSheet" href="btnet.css" type="text/css">
</head>
<body onload="document.forms[0].user.focus()"><div style="float: right;">
<!--<span>
	<a target=_blank style=" font-size: 7pt; font-family: arial; letter-spacing: 1px;" href=http://ifdefined.com/bugtrackernet.html>TDSS Bugs Tracker</a>
	<br>
	<a target=_blank style=" font-size: 7pt; font-family: arial; letter-spacing: 1px;" href=http://ifdefined.com/README.html>Help</a>
	<br>
	<a target=_blank style=" font-size: 7pt; font-family: arial; letter-spacing: 1px;" href=mailto:ctrager@yahoo.com>Feedback</a>
	<br>
	<a target=_blank style=" font-size: 7pt; font-family: arial; letter-spacing: 1px;" href=about.html>About</a>
	<br>
	<a target=_blank style=" font-size: 7pt; font-family: arial; letter-spacing: 1px;" href=http://ifdefined.com/README.html>Donate</a>
</span>-->
</div>
<div>

</div>
<div class="body">
</div>
<table border=0><tr>

<%

Response.Write (Application["custom_logo"]);

%>

</table>


<div align="center">
<table border="0" class="style5"><tr><td class="style2">
<form id="Form1" class="frm" runat="server">
	<% if (Util.get_setting("WindowsAuthentication", "0") != "0") { %>
		<tr><td colspan="2" class="smallnote">To login using your Windows ID, leave User blank</td></tr>
	<% } %>
    <div class="login">
    <input type="text" placeholder="Username" id="user"  runat="server" />  
  <input type="password" placeholder="password" id="pw" runat="server"/>
   
  <input type="submit" id="Submit1" class="btn" value="Logon"/>
</div>
<%--<tr><td colspan="2" align="left">
	<span runat="server" class="err" id="Span1">&nbsp;</span>
	</td></tr>--%>
<%--<div class="shadow">
</div>--%>	
<span runat="server" class="err" id="msg" style="padding:40px 52px;">&nbsp;</span> 
</form>
<span>

<% if (Util.get_setting("AllowGuestWithoutLogin","0") == "1") { %>
<p>
<a style="font-size: 8pt;"href="bugs.aspx">Continue as "guest" without logging in</a>
<p>
<% } %>

<% if (Util.get_setting("AllowSelfRegistration","0") == "1") { %>
<p>
<a style="font-size: 8pt;"href="register.aspx">Register</a>
<p>
<% } %>

<% if (Util.get_setting("ShowForgotPasswordLink","1") == "1") { %>
<p>
<a style="font-size: 8pt;"href="forgot.aspx">Forgot your username or password?</a>
<p>
<% } %>


</span>

</td></tr></table>

<% Response.Write (Application["custom_welcome"]); %>
</div>
</body>
</html>