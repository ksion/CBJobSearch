using System;
using System.Collections.Generic;
using com.careerbuilder;
using com.careerbuilder.api;
using com.careerbuilder.api.models;
using com.careerbuilder.api.models.service;
using com.careerbuilder.api.models.responses;
using System.Collections;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Collections.Specialized;

namespace CBJobSearch
{
    public partial class _Default : System.Web.UI.Page
    {
        ResponseJobSearch answers = null;

        static NameValueCollection appSettings = ConfigurationManager.AppSettings;
        static string[] values = appSettings.GetValues(0);
        static ICBApi api = API.GetInstance(values[0]);

        List<Category> cats = api.GetCategories().WhereCountryCode(CountryCode.US).ListAll();

        protected void Page_Load(object sender, EventArgs e)
        {
            prepareDropDownList();

            if (IsPostBack)
            {
                /* Values from form */
                var category = DropDown1.SelectedValue;
                var location = TextBox1.Text;
                var keywords = TextBox2.Text;
                /* Values from API */
                Category catToSearch = findCategory(cats, category);
                answers = performSearch(location, keywords, catToSearch);

                if (answers.Results.Count > 0)
                {
                    ph_searchRes.Visible = true;
                    rptList.DataSource = answers.Results;
                    rptList.DataBind();
                }

            }
        }

        private void prepareDropDownList()
        {
            DropDown1.Items.Add(new ListItem("What Job Category?", "ALL"));

            foreach (var category in cats)
            {
                DropDown1.Items.Add(new ListItem(category.Names[0].Value, category.Code));
            }
        }

        private ResponseJobSearch performSearch(string location, string keywords, Category catToSearch)
        {
            ResponseJobSearch ace;

            if (catToSearch != null)
            {
                ace = api.JobSearch()
                    .WhereKeywords(keywords.ToString())
                    .WhereLocation(location.ToString())
                    .WhereCategories(catToSearch)
                    .OrderBy(OrderByType.Title)
                    .Ascending()
                    .Search();
            }
            else
            {
                ace = api.JobSearch()
                    .WhereKeywords(keywords.ToString())
                    .WhereLocation(location.ToString())
                    .OrderBy(OrderByType.Title)
                    .Ascending()
                    .Search();
            };

            return ace;
        }

        /**
         * Validates the input string for keyowrds by seeing if the input is empty.
         * If the condition does not pass, the keyword search will be based off the
         * input from the form.
         */
        private static string validateKeyWords(string keywords)
        {
            string ace = null;

            if (keywords != null)
            {
                ace = keywords;
            }

            return ace;
        }

        /**
         * Validates the input string for location by seeing if the input is the default
         * text or empty. If the condition passes, the default location is set to 
         * Atlanta, GA. If the condition does not pass, the location will be set to null
         * and the search will be based off the input from the textbox.
         */
        private static string validateLocation(string location)
        {
            string ace = null;

            if (location.Length == 0)
            {
                ace = "Atlanta, GA";
            }

            return ace;
        }

        /**
         * Finds the category specified by string user input and converts it to an
         * actual job category. If the input string does not match any of the codes,
         * the search will default to all of the job categories.
         */
        private static Category findCategory(List<Category> codes, string category)
        {
            Category ace = null;

            foreach (Category x in codes)
            {
                if (x.Code.Equals(category))
                {
                    ace = x;
                }
            }

            return ace;
        }
    }
}
