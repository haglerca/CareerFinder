using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //menu Controls
        HtmlControl cntrl = (HtmlControl)Master.FindControl("liHome");

        if (cntrl != null)
        {
            cntrl.Attributes["class"] = "current_page_item";
        }//end menu controls



    }
}