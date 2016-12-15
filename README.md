# Principal Officers

## From instructions to VSFS Interns

Thank you for waiting for me on this new assignment. This one builds on the review you’ve done for the Chiefs of Mission, and adds several new components.
 
In this assignment, your attention will turn from Chiefs of Mission to our Department’s Principal Officers. In Chiefs of Mission, our main problem was the fact that our website mixed people who actually served in the position with those who did not. Your hard work up to this point has allowed us to present a far more accurate history on our website. We’ve been rolling out your changes as I get a chance to edit them; here’s how your work from Nicaragua turned out: https://history.state.gov/departmenthistory/people/chiefsofmission/nicaragua. Needless to say, this is a significant improvement over the past, and we couldn’t have done it without you.
 
In the Principal Officers, we have that same problem of “other nominees,” and you’ll be tackling that here. But we also have an additional problem: titles of positions have changed/evolved throughout the years, but our website does not accurately track those changes. While all the necessary information is on the website, the lists of officeholders don’t correctly reflect the titles people had while they were in office. So, your work on this job will involve a bit more historical sleuthing (although we’ll provide you with all the information you need – you shouldn’t need to do any additional research outside of what we provide). So, let’s dive in to the job itself!  

First, you’ll still be looking for errors in the existing data and slotting "other appointees" into the appropriate column. 

Also, as before, I’ve provided schema for the files to help you find some issues and keep the files in the right structure.

What is new is that we are adapting the original data into a new, more historically-sensitive structure. Specifically, we’ve had no good way to capture historical forms of a principal officer’s title. For example, today’s “Assistant Secretary of State for East Asian and Pacific Affairs” used to be called the “Assistant Secretary of State for Far Eastern Affairs.” But our current website lists all holders of the latter title as if they had the former title. (See https://history.state.gov/departmenthistory/people/principalofficers/assistant-secretary-for-east-asian-pacific-affairs.)  The only way we could let readers know about the change in title was by means of the introductory note or in footnotes attached to individual positions. (For example, see the first entry for https://history.state.gov/departmenthistory/people/butterworth-william-walton.)  

You will be taking this information buried in introductory notes or footnotes, and capturing it in our database. To do so, you will create a new database record for historical titles (e.g., Assistant Secretary of State for Far Eastern Affairs), drawing on the dates and information from the introductory note, and you’ll link this earlier "predecessor" office to its present-day “successor” office. 
 
I’ve created two fully fleshed out examples - (1) the Assistant Secretary of State for East Asian and Pacific Affairs and (2) the more complex case of the Undersecretary of State for Economic, Energy, and Business Affairs - and have attached the resulting files in the attached zip file. Here is a guide to the contents:

- principal-officers.xpr: the oXygen Project file that lets you browse the files in oXygen. Start by opening this file in oXygen. 

- data/: the folder with the data you’ll be using

    - data/timeline.xml: A timeline of events in the Department’s administrative history that you can use as a reference. This often has more detailed information than the introductory notes, and is especially useful for finding the start and end dates for offices.
    
    - OLD-DATA/: This contains the existing data that you see on history.state.gov under https://history.state.gov/departmenthistory/people/principalofficers.
    
    - principal-offices/: You will put most of your new work in the this folder’s subfolders:

        - current-offices/: This is where you’ll store the files for offices that the Department has in place today (e.g., assistant-secretary-of-state-for-east-asian-and-pacific-affairs.xml). Information about the office and the list of all officers and other appointees to each position (the “officers”) goes in these files. 
        
        - predecessor-offices/: For previous incarnations of current offices (e.g., assistant-secretary-of-state-for-far-eastern-affairs-1966.xml; the -1966 suffix indicates that the record *ends* in 1966). These files contain only information about the office; no officers are listed in these files. The officers who held these positions are all stored in the current-offices subdirectory.
        
        - discontinued-offices/: From time to time the Department completely discontinues an office. An example is the “Third Secretary of State” (third-assistant-secretary-of-state.xml). The list of all officers and other appointees to each position go in these file.

    - units/: You won’t use this much, but if you come across information about a “unit” (e.g., a Bureau of X Affairs) that doesn’t mention the title of the principal officer (e.g., Assistant Secretary for X Affairs), you can capture the information about that unit in this directory. I did this for the “Division of Far Eastern Affairs,” which our introductory note explains predated the Assistant Secretary of State for Far Eastern Affairs. The files in this folder are also split into current, predecessor, and discontinued subfolders. I’ve populated the “current” subfolder with a complete list of the bureaus in the Department, albeit without dates. 
 
    - ranks/: Each office is classified according to a system of “ranks.” I think I’ve captured them all already, so you can use this list to find the ID for each rank.

I’ve also attached a rough mockup of how the new information will look in a webpage. Here are the key things you will notice have changed, compared to what you see on the current site for these two positions (https://history.state.gov/departmenthistory/people/principalofficers/assistant-secretary-for-east-asian-pacific-affairs and https://history.state.gov/departmenthistory/people/principalofficers/under-secretary-for-econ-business-ag):

1. Instead of an introductory paragraph, we have a new section, “History of this Office,” which lists the title, dates, and notes for each incarnation of the office.

2. The list of officers shows the contemporary office when it differs from the current one. If the title changed during someone’s term of service, the change is noted. 
 
I think that the best way to get started is to review the two examples I fleshed out, and note how I captured/adapted the “OLD-DATA” into what you see in the principal-offices and units folders. Then, when you’re ready to take a stab at adapting a file yourself, I’d suggest starting with the Secretary of State, then working through the Assistant Secretaries of State or Equivalents with Functional Designations listed at https://history.state.gov/departmenthistory/people/principalofficers. 

Let’s talk through how to approach the Secretary of State. Find this file in the OLD DATA folder, copy the file into principal-offices/current-offices, and open it. Select the “Validate” icon in the oXygen toolbar (also accessible via Document > Validate), and notice the first two errors say that the “valid-from” and “valid-until” elements are invalid dates; the schema wants you to provide full dates (YYYY-MM-DD) for the start and end of this bureau. Read the introductory <note> to find the full date when this position was created, 1789-07-27; since the office is current, delete the “2005” text from the “valid-until” field. (We interpret an empty “valid-until” field for current-offices as meaning “to the present.”) The introductory note discusses several major changes in the Department’s organization. Capture the units described in the text: the Department of Foreign Affairs (1789-07-27 - 1789-09-04) and the Department of State (1789-09-05 - present); note that the end date of the former is one day before the start date of the latter. As you’re filling information in, you may encounter fields you don’t know what to do with or don’t know quite how to handle. This is fine! Let me know if you have any questions. And I’ll be happy to review your first submission and let you know if you’re on the right track. 
