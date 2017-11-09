
/**
 * Created by PhpStorm.
 * User: Deaunte Gay
 * Date: 11/5/2017
 * Time: 1:07 AM
 */
<html>

<head>

    <title>Actor Search</title>

</head>

<body>

<form action="actors_search.php.php" align="center" method="POST">

    Enter Actor Full Name: <input type="text" align="center" name="fullNameSearch" required="required"/> <br/><br/>

    <input type="submit" value="Submit"/> <br/><br/>

    <div align="center">

        <a href="index.php">Back to Home</a>

    </div>

</form>

</body>



</html>

<?php

if($_SERVER["REQUEST_METHOD"] == "POST"){



    //Connects to server

    mysql_connect("localhost", "root", "") or die(mysql_error());



    //Connects to database

    mysql_select_db("cbsi_movies_db") or die ("Cannot connect to database");



    //Variable to store the string from the user's input

    $full_name = mysql_real_escape_string($_POST['fullNameSearch']);



    //Boolean variable to see if the actor was found within the Actors table.

    $found_bool = false;



    //SQL query to see if the actor exists within the Actors table

    $actor_query = mysql_query("SELECT fullName,id FROM actors

    WHERE fullName = '$full_name' LIMIT 1");



    $row = mysql_fetch_array($actor_query);



    //If the inputted string matches the full name of an actor in the Actor table,

    //then output the financial information about that specific actor.

    if($full_name == $row['fullName'])

    {

        $found_bool = true;

        $found_id = $row['id'];

        print "<b>Actor's Full Name: </b>".$row['fullName']."<br/><br/>";





        $pay_query = mysql_query("SELECT title, basePay,

      (payments.revShare*movies.revenue/100) payout

      FROM payments JOIN movies ON payments.movieId = movies.id

      WHERE payments.actorId = '$found_id'");



        if($pay_query === FALSE){

            die(mysql_error());

        }



        while($pay_row = mysql_fetch_array($pay_query)){

            print "The actor starred in: <b>".$pay_row['title']."</b><br/>";

            print "Base Payment: <b>$".number_format($pay_row['basePay'],2)."</b><br/>";

            print "Revenue Share Payout: <b>$".number_format($pay_row['payout'],2)."</b><br/><br/>";

        }



        /*

        //SQL Query to find all movies that the actor starred in

        $starred_query = mysql_query("SELECT * FROM movies ORDER BY title");



        if($starred_query === FALSE) {

          die(mysql_error());

        }



        while ($aim_row = mysql_fetch_array($starred_query)){

          //SWITCH statement to properly show the financial informaton about an

          //actor regardless of the position they were entered into the database

          switch ($full_name) {

            case $aim_row['actor1']:

              print "Actor starred in: <b>".$aim_row['title']."</b><br/>";

              print "The actor was paid a base amount of <b>$"

              .number_format($aim_row['base1'],2)."</b> and received <b>$"

              .number_format($aim_row['rev1']*$aim_row['revenue']/100.00,2)

              ."</b> from revenue shares.<br/><br/>";

              break;

            case $aim_row['actor2']:

              print "Actor starred in: <b>".$aim_row['title']."</b><br/>";

              print "The actor was paid a base amount of <b>$"

              .number_format($aim_row['base2'],2)."</b> and received <b>$"

              .number_format($aim_row['rev2']*$aim_row['revenue']/100.00,2)

              ."</b> from revenue shares.<br/><br/>";

              break;

            case $aim_row['actor3']:

              print "Actor starred in: <b>".$aim_row['title']."</b><br/>";

              print "The actor was paid a base amount of <b>$"

              .number_format($aim_row['base3'],2)."</b> and received <b>$"

              .number_format($aim_row['rev3']*$aim_row['revenue']/100.00,2)

              ."</b> from revenue shares.<br/><br/>";

              break;

            case $aim_row['actor4']:

              print "Actor starred in: <b>".$aim_row['title']."</b><br/>";

              print "The actor was paid a base amount of <b>$"

              .number_format($aim_row['base4'],2)."</b> and received <b>$"

              .number_format($aim_row['rev4']*$aim_row['revenue']/100.00,2)

              ."</b> from revenue shares.<br/><br/>";

              break;

            default:

              break;

          }

        }*/

    }



    //If the actor was not found, display that fact to the user

    if(!$found_bool){

        echo "Actor <b>(".$full_name.")</b> not found!<br/>";

    }







}

?>