use IndiaElectionResults;
select * from constituencywise_details order by Total_votes ;

select Top 5 S_N, SUM(Total_votes)as total from constituencywise_details group by S_N order by total desc ;

--Total Seats
-- Counting the total number of unique parliamentary constituencies
SELECT 
    COUNT(DISTINCT Parliament_Constituency) AS Total_Seats
FROM 
    constituencywise_results;


---What is the total number of seats available for elections in each state?
-- Query to determine the total number of parliamentary seats available for elections in each state
SELECT 
    s.State AS State_Name,  -- Extracting the state name
    COUNT(cr.Constituency_ID) AS Total_Seats_Available  -- Counting total seats (constituencies) per state
FROM 
    constituencywise_results cr
JOIN 
    statewise_results sr 
    ON cr.Parliament_Constituency = sr.Parliament_Constituency  -- Joining with statewise results using constituency
JOIN 
    states s 
    ON sr.State_ID = s.State_ID  -- Joining with states table to get state names
GROUP BY 
    s.State  -- Grouping by state to get seat count for each state
ORDER BY 
    s.State;  -- Ordering results alphabetically by state name


---Total Seats Won by NDA Allianz
-- Query to calculate the total number of seats won by the NDA alliance
SELECT 
    SUM(
        CASE 
            WHEN party IN (
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
            ) 
            THEN Won
            ELSE 0 
        END
    ) AS NDA_Total_Seats_Won
FROM 
    partywise_results;


--Seats Won by NDA Allianz Parties
-- Query to retrieve the number of seats won by each NDA alliance party
SELECT 
    party AS Party_Name,  -- Extracting the party name
    won AS Seats_Won      -- Extracting the number of seats won
FROM 
    partywise_results
WHERE 
    -- Filtering only NDA alliance parties
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY 
    won DESC;  -- Sorting results in descending order of seats won


-- Query to calculate the total number of seats won by the I.N.D.I.A. alliance
SELECT 
    SUM(
        CASE 
            -- Checking if the party belongs to the I.N.D.I.A. alliance
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
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
            THEN [Won]  -- Adding the number of seats won by these parties
            ELSE 0 
        END
    ) AS INDIA_Total_Seats_Won  -- Alias for total seats won by the I.N.D.I.A. alliance
FROM 
    partywise_results;

-- Query to retrieve the number of seats won by each I.N.D.I.A. alliance party
SELECT 
    party AS Party_Name,  -- Extracting the party name
    won AS Seats_Won      -- Extracting the number of seats won by each party
FROM 
    partywise_results
WHERE 
    -- Filtering only I.N.D.I.A. alliance parties
    party IN (
        'Indian National Congress - INC',
        'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
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
ORDER BY 
    won DESC;  -- Sorting results in descending order of seats won


---Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
-- Altering the table 'partywise_results' to add a new column 'party_alliance'
-- This column will categorize parties under NDA, I.N.D.I.A., or OTHER alliances
ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);  -- Adding a new column with a maximum length of 50 characters



-- Updating the 'party_alliance' column in 'partywise_results' table
-- Assigning 'I.N.D.I.A' alliance to relevant parties
UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
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
);


-- Updating the 'party_alliance' column in 'partywise_results' table
-- Assigning 'NDA' alliance to relevant parties
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

-- Updating the 'party_alliance' column to 'OTHER' for parties that do not belong to NDA or I.N.D.I.A.
-- This ensures that all parties are categorized under one of the three alliances
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;


-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
-- Retrieving the party alliance (NDA, I.N.D.I.A, or OTHER) that won the most seats across all states
SELECT 
    p.party_alliance,  -- Party alliance category (NDA, I.N.D.I.A, or OTHER)
    COUNT(cr.Constituency_ID) AS Seats_Won  -- Total seats won by each alliance
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID  -- Joining with partywise_results to get party alliance details
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')  -- Filtering to include only valid alliances
GROUP BY 
    p.party_alliance  -- Grouping by party alliance to get the count per alliance
ORDER BY 
    Seats_Won DESC;  -- Sorting in descending order to show the alliance with the most seats at the top



---Winning candidate's name, their party name, total votes, and the 
---margin of victory for a specific state and constituency?
-- Retrieving the winning candidate's details, their party, total votes, and margin of victory 
-- for a specific state and constituency (e.g., 'Uttar Pradesh' and 'AMETHI')
SELECT 
    cr.Winning_Candidate,   -- Name of the winning candidate
    p.Party,                -- Name of the candidate's party
    p.party_alliance,       -- Party alliance (NDA, I.N.D.I.A, or OTHER)
    cr.Total_Votes,         -- Total votes received by the winning candidate
    cr.Margin,              -- Margin of victory in terms of votes
    cr.Constituency_Name,   -- Name of the constituency
    s.State                 -- Name of the state
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID  -- Joining to get party details
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency  -- Joining to map constituency to state
JOIN 
    states s ON sr.State_ID = s.State_ID  -- Joining to get state details
WHERE 
    s.State = 'Uttar Pradesh'  -- Filtering for the specific state
    AND cr.Constituency_Name = 'AMETHI';  -- Filtering for the specific constituency



---What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
-- Retrieving the distribution of EVM votes versus postal votes for candidates 
-- in a specific constituency (e.g., 'MATHURA')
SELECT 
    cd.Candidate,        -- Name of the candidate
    cd.Party,            -- Candidate's party affiliation
    cd.EVM_Votes,        -- Number of votes received via EVM (Electronic Voting Machine)
    cd.Postal_Votes,     -- Number of votes received via postal ballots
    cd.Total_Votes,      -- Total votes received by the candidate
    cr.Constituency_Name -- Name of the constituency
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr 
    ON cd.Constituency_ID = cr.Constituency_ID  -- Joining to get constituency details
WHERE 
    cr.Constituency_Name = 'MATHURA'  -- Filtering for the specific constituency
ORDER BY 
    cd.Total_Votes DESC;  -- Sorting candidates by total votes in descending order


--Which parties won the most seats in s State, and how many seats did each party win?
-- Retrieving the parties that won the most seats in a specific state 
-- and the total number of seats won by each party (e.g., 'Andhra Pradesh')
SELECT 
    p.Party,  -- Name of the political party
    COUNT(cr.Constituency_ID) AS Seats_Won  -- Total seats won by the party in the state
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID  -- Joining to get party details
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency  -- Mapping constituencies to states
JOIN 
    states s ON sr.State_ID = s.State_ID  -- Joining to get state details
WHERE 
    s.state = 'Andhra Pradesh'  -- Filtering for the specific state
GROUP BY 
    p.Party  -- Grouping by party to get the count of seats won
ORDER BY 
    Seats_Won DESC;  -- Sorting in descending order to show parties with the most seats first

--- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
-- Retrieving the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER)
-- in each state for the India Elections 2024
SELECT 
    s.State AS State_Name,  -- Name of the state
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,  -- Total seats won by NDA alliance
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,  -- Total seats won by I.N.D.I.A alliance
    SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won  -- Total seats won by other parties
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID  -- Joining to get party details
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency  -- Mapping constituencies to states
JOIN 
    states s ON sr.State_ID = s.State_ID  -- Joining to get state details
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')  -- Filtering for valid party alliances
GROUP BY 
    s.State  -- Grouping results by state to get seats won per alliance in each state
ORDER BY 
    s.State;  -- Sorting alphabetically by state name


---Which candidate received the highest number of EVM votes in each constituency (Top 10)?
-- Retrieving the top 10 candidates with the highest EVM votes from each constituency
SELECT TOP 10
    cr.Constituency_Name,  -- Name of the constituency
    cd.Constituency_ID,    -- Unique ID of the constituency
    cd.Candidate,          -- Candidate name
    cd.EVM_Votes           -- Number of EVM votes received
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID  -- Joining to get constituency details
WHERE 
    cd.EVM_Votes = (
        -- Subquery to find the highest EVM votes within each constituency
        SELECT MAX(cd1.EVM_Votes)
        FROM constituencywise_details cd1
        WHERE cd1.Constituency_ID = cd.Constituency_ID
    )
ORDER BY 
    cd.EVM_Votes DESC;  -- Sorting in descending order to get the highest EVM votes first

---Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
-- Using Common Table Expression (CTE) to rank candidates based on total votes within each constituency
WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,  
        cd.Candidate,        -- Candidate name
        cd.Party,            -- Party of the candidate
        cd.EVM_Votes,        -- Number of EVM votes received
        cd.Postal_Votes,     -- Number of postal votes received
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,  -- Calculating total votes
        -- Assigning rank to candidates within each constituency based on total votes in descending order
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Maharashtra'  -- Filtering for Maharashtra state
)

-- Retrieving the winning candidate and the runner-up for each constituency in Maharashtra
SELECT 
    cr.Constituency_Name,  -- Constituency name
    -- Extracting the winning candidate (rank 1) and runner-up (rank 2) using conditional aggregation
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name  -- Grouping results by constituency
ORDER BY 
    cr.Constituency_Name;  -- Sorting by constituency name



----For the state of Maharashtra, what are the total number of seats, total number of candidates, 
----total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
-- Query to get election statistics for the state of Maharashtra
SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,   -- Total number of seats (unique constituencies)
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,   -- Total number of candidates contesting
    COUNT(DISTINCT p.Party) AS Total_Parties,           -- Total number of parties participating
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes, -- Total votes cast (EVM + Postal)
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,              -- Total EVM votes cast
    SUM(cd.Postal_Votes) AS Total_Postal_Votes         -- Total postal votes cast
FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';  -- Filtering results for Maharashtra


