using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class JobPostings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //menu Controls
        HtmlControl cntrl = (HtmlControl)Master.FindControl("liJobPostings");

        if (cntrl != null)
        {
            cntrl.Attributes["class"] = "current_page_item";
        }//end menu controls



        //first time page loads
        if (!Page.IsPostBack)
        {
            //look for the qs id (jpid)
            //if it is not null
            if (Request.QueryString["jpid"] != null)
            {
                //switch datasource to the qs datasource
                gvJobPostings.DataSourceID = dsActiveJobPostingsQS.ID;

                //databind
                gvJobPostings.DataBind();

                //Add this code if you add a ddl to filter job postings
                //SelectedValue of the ddl to the qs value
                //DropDownListForJobPostings.SelectedValue = Request.QueryString["jpid"]

                //show the back button ONLY when arriving from the companies page via QueryString
                btnBackToCompanies.Visible = true;

                //hide rblJobPostingStatuses when you are taken to selected job posting
                rblJobPostingStatuses.Visible = false;
            }
            
        }



    }
    protected void rblShowActiveJobPostings_CheckedChanged(object sender, EventArgs e)
    {

       
       
    }
    protected void rblJobPostingStatuses_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblJobPostingStatuses.SelectedValue == "1")
        {
            gvJobPostings.DataSourceID = dsInactiveJobPostings.ID;
        }

        else
	{
        gvJobPostings.DataSourceID = dsActiveJobPostings.ID;
	}
        gvJobPostings.DataBind();


        
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {

    }
    protected void btnBackToJobPostings_Click(object sender, EventArgs e)
    {
        mvJobPostings.ActiveViewIndex = 0;
    }
    protected void gvJobPostings_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvJobPostings.ActiveViewIndex = 1;
    }
    protected void btnAddNewPosting_Click(object sender, EventArgs e)
    {
        dvSelectedJobPosting.ChangeMode(DetailsViewMode.Insert);
        mvJobPostings.ActiveViewIndex = 1;
        
    }
    protected void dsSelectedJobPosting_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //switch back to the GV
        mvJobPostings.ActiveViewIndex = 0;

        //update the GV
        gvJobPostings.DataBind();
    }
    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        mvJobPostings.ActiveViewIndex = 0;
    }
    protected void LinkButton2_Click2(object sender, EventArgs e)
    {
        mvJobPostings.ActiveViewIndex = 0;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        mvJobPostings.ActiveViewIndex = 0;
    }
    protected void LinkButton1_Click1(object sender, EventArgs e)
    {
        //update
        mvJobPostings.ActiveViewIndex = 0;

       
    }
    protected void dsSelectedJobPosting_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //switch back to the GV
        mvJobPostings.ActiveViewIndex = 0;

        //update the GV
        gvJobPostings.DataBind();
    }

    protected void btnBackToComapnies_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Companies.aspx");

    }


    //secure the LAST COLUMN of the Gridview
    protected void gvJobPostings_DataBound(object sender, EventArgs e)
    {
        //hide the change status if the user is not an admin
        if (!User.IsInRole("admin"))
        {
            //index is 0 base
            gvJobPostings.Columns[gvJobPostings.Columns.Count - 1].Visible = false;
        }
    }

    //secure the LAST ROW of the DetailsView
    protected void dvSelectedJobPosting_DataBound(object sender, EventArgs e)
    {
        if (!User.IsInRole("admin"))
        {
            dvSelectedJobPosting.Rows[dvSelectedJobPosting.Rows.Count - 1].Visible = false;
        }
    }

    protected void AdminControl_PreRender(object sender, EventArgs e)
    {
        //connect this to the PRE RENDER event of each control that u want to hide individually
        //(not used with the gv or dv)
        if (!User.IsInRole("admin"))
        {//cast this object to an control

            ((Control)sender).Visible = false;
        }

        //FOR MULTI USER, YOU CAN ADD THE USER TO A ROLE (CREATE THE ROLE IN THE WSAT i.e. RegisteredUser) AND
        //CHECK THAT THE ROLE AS WELL AS THE ADMIN

        //additionally you will need to add the user to this role in ur create user wizard event handler
        //(see ASP2 - createUserWizard)

        //
        //if (!User.IsInRole("admin") || !User.IsInRole("registeredUser"))
        //{
        //    ((Control)sender).Visible = false;
        //}
    }



}