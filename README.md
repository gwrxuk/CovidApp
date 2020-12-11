# CovidApp

This app aims to provide COVID-19 information and rule in Germany.

This app detects user's location in LocationManager.swift and send the coordinate to https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/917fc37a709542548cc3be077a786c17_0 API to obtain COVID-19 confirmed cases. This app will fetch data every 10 mins.


You can change the display criteria in Warning.plist. In this file, you can define different warning levels. Each level contains MIN for minimum cases, MAX for maximum cases, Color for warning color in hex, and Instruction for the rule. Currently, we use color code for locationalizing instruction. You can change rule text in Localizable.string files.




