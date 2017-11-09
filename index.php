/**
 * Created by PhpStorm.
 * User: Deaunte Gay
 * Date: 11/5/2017
 * Time: 1:09 AM
 */
<html>

<head>

    <title>Home Page</title>

</head>

<br/>

<br/>

<table width="100%" style="max-width:50%;" align="center" border="1px">

    <tr>

        <th>Actor Name</th>

        <th>Actor Revenue</th>

    </tr>

    <?php

    //Connects to server

    mysql_connect("localhost","root","") or die(mysql_error());



    //Connects to database

    mysql_select_db("cbsi_movies_db") or die("Cannot connect to database");



    //SQL query for displaying the actors' names

    $actor_query = mysql_query("SELECT id,fullName FROM actors ORDER BY fullName");



    if($actor_query === FALSE){

        die(mysql_error());

    }



    print "<tr>";

    while($actor_row = mysql_fetch_array($actor_query)){

        $actor_rev_sum = 0;

        $rev_sum = 0;

        $curr_actor_id = $actor_row['id'];

        $curr_actor = $actor_row['fullName'];



        /*

         * SQL query to display the total revenue of each Actor

         * based on information stored in the Payments table.

         */

        $rev_query = mysql_query("SELECT basePay,

          (payments.revShare*movies.revenue/100) payout

          FROM payments LEFT JOIN movies

          ON payments.movieId = movies.id

          WHERE '$curr_actor_id' = payments.actorId");



        while ($rev_row = mysql_fetch_array($rev_query)){

            $currBase = $rev_row['basePay'];

            $currPayout = $rev_row['payout'];

            $rev_sum+= $currBase + $currPayout;

        }



        print '<td align="center">'.$curr_actor."</td>";

        print '<td align="center">'."$".number_format($rev_sum,2)."</td>";

        print "</tr>";

    }

    ?>

</table>

<br/><br/>



<table width="100%" style="max-width:50%;" align="center" border="1px">

    <tr>

        <th>Company Name</th>

        <th>Company Revenue</th>

        <th>Company Cost</th>

        <th>Company Profit(+)/Loss(-)</th>

    </tr>

    <?php

    /*

     * SQL query to display the companies' names, their total revenue,

     * their total costs, and their profits/losses.

     */

    $company_query = mysql_query("SELECT companies.companyName,

      SUM(movies.revenue) totalRevenue, SUM(movies.cost) totalCost,

      SUM(movies.revenue)-SUM(movies.cost) totalProfitLoss FROM companies

      LEFT JOIN movies ON movies.companyId = companies.id

      GROUP BY companies.companyName ORDER BY companies.companyName");



    if($company_query === FALSE){

        die(mysql_error());

    }



    while($company_row = mysql_fetch_array($company_query)){

        print "<tr>";

        print '<td align="center">'.$company_row['companyName']."</td>";

        print '<td align="center">$'.number_format($company_row['totalRevenue'],2)."</td>";

        print '<td align="center">$'.number_format($company_row['totalCost'],2)."</td>";

        print '<td align="center">$'.number_format($company_row['totalProfitLoss'],2)."</td>";

        print "</tr>";

    }

    ?>

</table>

<br/><br/>



<!--

Table displaying numbers of lines and words in each movie script for each

Actor and the number of times the Actor's character is mentioned in each

script by other Actors.

-->

<table width="100%" style="max-width:50%;" align="center" border="1px">

    <tr>

        <th>Movie Title</th>

        <th>Character Name</th>

        <th>Actor Name</th>

        <th>Number of Lines</th>

        <th>Number of Words</th>

        <th>Number of Mentions</th>

    </tr>

    <?php



    /*

     * SQL query to count the number of lines in each movie script for

     * each Actor.

     */

    $character_query = mysql_query("SELECT movies.title,

      characters.id, characters.name,

      actors.fullName, COUNT(scripts.characterId) charlines,

      scripts.movieId FROM characters

      LEFT JOIN scripts ON characters.id = scripts.characterId

      JOIN movies ON characters.movieId = movies.id

      JOIN actors ON characters.actorId = actors.id

      GROUP BY characters.name

      ORDER BY movies.title");



    if($character_query === FALSE){

        die(mysql_error());

    }



    while($character_row = mysql_fetch_array($character_query)){



        //Buffer variables for the current Character, CharacterID, and MovieID

        $currCharacter = $character_row['name'];



        $currCharacterId = $character_row['id'];

        //echo $currCharacter." ".$currCharacterId."<br/>";

        $currMovieId = $character_row['movieId'];



        //Counter variables for the number of mentions and words for each Actor.

        $mentionCount = 0;

        $wordsCount = 0;



        /*

         * SQL query to count the number of times an Actor's character is

         * mentioned in each script by other Actors.

         */

        $mention_query = mysql_query("SELECT scripts.lineText

          FROM scripts

          WHERE '$currCharacterId' != scripts.characterId

          AND '$currMovieId' = scripts.movieId");



        if($mention_query === FALSE){

            die(mysql_error());

        }

        while ($mention_row = mysql_fetch_array($mention_query)){

            //echo $mention_row['lineText']."<br/>";

            $currLineArray = explode(" ",$mention_row['lineText']);

            foreach ($currLineArray as $word){

                if(strpos($word,$currCharacter) !== FALSE){

                    $mentionCount++;

                }

            }

        }



        /*

         * SQL query to count the number of words in each movie script for

         * each Actor.

         */

        $script_query = mysql_query("SELECT scripts.lineText

          FROM scripts

          JOIN characters ON characters.id = scripts.characterId

          WHERE '$currCharacter' = characters.name");



        if($script_query === FALSE){

            die(mysql_error());

        }



        while ($script_row = mysql_fetch_array($script_query)){

            $wordsCount += count(explode(" ",$script_row['lineText']));

        }



        //Table displaying the aforementioned information

        print "<tr>";

        print '<td align="center">'.$character_row['title']."</td>";

        print '<td align="center">'.$character_row['name']."</td>";

        print '<td align="center">'.$character_row['fullName']."</td>";

        print '<td align="center">'.$character_row['charlines'].'</td>';

        print '<td align="center">'.$wordsCount.'</td>';

        print '<td align="center">'.$mentionCount.'</td>';

        print "</tr>";

    }

    ?>

</table>

<br/><br/>



<body>

<div align="center">

    <a href="actors_search.php">Click here for Actor Lookup</a> <br/><br/>

    <a href="movie_form.php">Click here to add new Movie Entry</a> <br/><br/>

</div>

</body>



</html>