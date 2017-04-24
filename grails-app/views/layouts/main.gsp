<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Plotter"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    %{--  		<asset:stylesheet src="application.css"/>
            <asset:javascript src="application.js"/>--}%

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- jQuery library -->
    <script src="${resource(dir: 'js', file: 'jquery.min.js')}"></script>

    <!-- Latest compiled JavaScript -->
    <script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'vue.js')}"></script>
    <script src="${resource(dir: 'js', file: 'vue-router.js')}"></script>

    <g:layoutHead/>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">

        <div class="navbar-header">
            <a class="navbar-brand" href="#">JFT Employee Portal</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/employeeList">Home</a></li>
            <li class="active"><a href="/logout">Logout</a></li>
        </ul>
    </div>
</nav>

<g:layoutBody/>
</body>
</html>
