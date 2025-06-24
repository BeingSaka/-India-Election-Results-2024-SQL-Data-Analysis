📊 India Election Results 2024: SQL Data Analysis
This repository contains a comprehensive SQL data analysis project focused on the 2024 Indian General Election results. The project leverages SQL queries to extract meaningful insights from election data, covering aspects such as constituency-wise details, party performance, alliance statistics (NDA and I.N.D.I.A), and detailed vote distribution.

✨ Project Overview
The India Election Results 2024 project demonstrates strong SQL querying and data manipulation skills. It involves analyzing a dataset containing detailed election outcomes to answer critical questions about the election landscape, providing a clear picture of the results and key trends.

🚀 Key Features & Analysis Performed
This project performs various analyses using SQL queries, designed to uncover specific insights from the election data:

Top Constituencies by Total Votes

Description: Identifies constituencies with the highest vote counts.

Query:

select Top 5 S_N, SUM(Total_votes)as total from constituencywise_details group by S_N order by total desc ;

Total Seats Available for Elections

Description: Calculates the total number of unique parliamentary constituencies.

Query:

SELECT COUNT(DISTINCT Parliament_Constituency) AS Total_Seats FROM constituencywise_results;

State-wise Seat Distribution

Description: Determines the total number of parliamentary seats available in each state.

Query:

SELECT s.State AS State_Name, COUNT(cr.Constituency_ID) AS Total_Seats_Available
FROM constituencywise_results cr
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY s.State;

NDA Alliance Performance - Total Seats Won

Description: Calculates the total seats won by the National Democratic Alliance (NDA).

Query:

SELECT SUM(CASE WHEN party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal (Secular) - JD(S)',
    'Lok Janshakti Party (Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
    ) THEN Won ELSE 0 END) AS NDA_Total_Seats_Won
FROM partywise_results;

NDA Alliance Performance - Seats Won by Individual Parties

Description: Lists seats won by individual parties within the NDA.

Query:

SELECT party AS Party_Name, won AS Seats_Won
FROM partywise_results
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY won DESC;

I.N.D.I.A Alliance Performance - Total Seats Won

Description: Calculates the total seats won by the Indian National Developmental Inclusive Alliance (I.N.D.I.A.).

Query:

SELECT SUM(CASE WHEN party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India (Marxist) - CPI(M)',
    'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
    ) THEN [Won] ELSE 0 END) AS INDIA_Total_Seats_Won
FROM partywise_results;

I.N.D.I.A Alliance Performance - Seats Won by Individual Parties

Description: Lists seats won by individual parties within the I.N.D.I.A. alliance.

Query:

SELECT party AS Party_Name, won AS Seats_Won
FROM partywise_results
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India (Marxist) - CPI(M)',
    'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY won DESC;

Categorization of Party Alliances

Description: Adds a new column party_alliance to categorize parties as 'NDA', 'I.N.D.I.A', or 'OTHER'.

Queries:

ALTER TABLE partywise_results ADD party_alliance VARCHAR(50);
UPDATE partywise_results SET party_alliance = 'I.N.D.I.A' WHERE party IN (...);
UPDATE partywise_results SET party_alliance = 'NDA' WHERE party IN (...);
UPDATE partywise_results SET party_alliance = 'OTHER' WHERE party_alliance IS NULL;

Alliance with Most Seats Nationally

Description: Identifies which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states.

Query:

SELECT p.party_alliance, COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
WHERE p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY p.party_alliance
ORDER BY Seats_Won DESC;

Winning Candidate & Margin of Victory for Specific Constituency

Description: Retrieves details of the winning candidate, their party, total votes, and margin of victory for a specified state and constituency (e.g., 'Uttar Pradesh' and 'AMETHI').

Query:

SELECT cr.Winning_Candidate, p.Party, p.party_alliance, cr.Total_Votes, cr.Margin,
       cr.Constituency_Name, s.State
FROM constituencywise_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE s.State = 'Uttar Pradesh' AND cr.Constituency_Name = 'AMETHI';

EVM vs. Postal Vote Distribution per Candidate in a Constituency

Description: Analyzes the distribution of EVM votes versus postal votes for candidates in a specific constituency (e.g., 'MATHURA').

Query:

SELECT cd.Candidate, cd.Party, cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cr.Constituency_Name
FROM constituencywise_details cd
JOIN constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE cr.Constituency_Name = 'MATHURA'
ORDER BY cd.Total_Votes DESC;

Party-wise Seats Won in a Specific State

Description: Identifies parties that won the most seats in a given state and the count of seats for each (e.g., 'Andhra Pradesh').

Query:

SELECT p.Party, COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE s.state = 'Andhra Pradesh'
GROUP BY p.Party
ORDER BY Seats_Won DESC;

Alliance-wise Seats Won per State

Description: Provides the total seats won by NDA, I.N.D.I.A, and OTHER alliances in each state.

Query:

SELECT s.State AS State_Name,
       SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
       SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
       SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM constituencywise_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY s.State
ORDER BY s.State;

Top EVM Vote Receivers (Top 10 Overall)

Description: Lists the top 10 candidates who received the highest EVM votes across all constituencies.

Query:

SELECT TOP 10 cr.Constituency_Name, cd.Constituency_ID, cd.Candidate, cd.EVM_Votes
FROM constituencywise_details cd
JOIN constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE cd.EVM_Votes = (SELECT MAX(cd1.EVM_Votes) FROM constituencywise_details cd1 WHERE cd1.Constituency_ID = cd.Constituency_ID)
ORDER BY cd.EVM_Votes DESC;

Winner and Runner-up in Each Constituency of a Specific State

Description: Identifies the winning candidate and the runner-up for each constituency in a specified state (e.g., 'Maharashtra').

Query (using CTE):

WITH RankedCandidates AS (
    SELECT cd.Constituency_ID, cd.Candidate, cd.Party, cd.EVM_Votes, cd.Postal_Votes,
           cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
           ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM constituencywise_details cd
    JOIN constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN states s ON sr.State_ID = s.State_ID
    WHERE s.State = 'Maharashtra'
)
SELECT cr.Constituency_Name,
       MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
       MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM RankedCandidates rc
JOIN constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY cr.Constituency_Name
ORDER BY cr.Constituency_Name;

Election Statistics for a Specific State (Comprehensive)

Description: Provides a summary of election statistics for a given state (e.g., 'Maharashtra'), including total seats, candidates, parties, and a breakdown of EVM and postal votes.

Query:

SELECT COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
       COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
       COUNT(DISTINCT p.Party) AS Total_Parties,
       SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
       SUM(cd.EVM_Votes) AS Total_EVM_Votes,
       SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM constituencywise_results cr
JOIN constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
WHERE s.State = 'Maharashtra';

🗳️ Dataset
The dataset used for this analysis is assumed to contain detailed information about the 2024 Indian General Elections, structured across several tables (e.g., constituencywise_details, constituencywise_results, statewise_results, states, partywise_results). This allows for comprehensive join operations and aggregated analyses.

🛠️ Technologies Used
SQL (MySQL): For data manipulation, querying, and analysis.

📖 How to Use
Database Setup:

Ensure you have a MySQL environment set up.

Import the election results dataset into your MySQL database. (You may need to define the table schemas based on the queries provided or source the original dataset if available).

Run Queries:

Execute the SQL queries provided in this repository (e.g., in a .sql file) using your preferred MySQL client (e.g., MySQL Workbench, DBeaver, or command-line).

📈 Insights & Conclusions
This project provides a robust SQL framework for analyzing election data. Key insights derived include:

Understanding constituency-level voting patterns.

Assessing the strength of major political alliances (NDA, I.N.D.I.A) at both national and state levels.

Identifying winning and runner-up candidates in specific regions.

Analyzing the distribution of votes between EVM and postal ballots.

Summarizing key election statistics for various states.

These insights are crucial for understanding the dynamics of the 2024 Indian General Election outcomes.

🤝 Contribution
Feel free to fork this repository, suggest improvements, or contribute additional analyses.
