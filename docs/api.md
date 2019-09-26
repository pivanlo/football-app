## Football App API

Use the Football App HTTP API to list the leagues for which there are results available
and list the matches for a specific league.

### List leagues

Lists all the leagues (a league is a division and season pair).

```endpoint
GET /api/leagues
```

#### Query string parameters

Name | Type | Required/Optional | Description
---|---|---|---
`type` | String | Optional | The format of the response. Available values are `json` and `protobuf`. If not specified, the value defaults to `json`.

#### Sample request

```curl
curl 'http://localhost/api/leagues'
```

#### Sample response

```json
[  
   {  
      "season":"201617",
      "div":"E0"
   },
   {  
      "season":"201516",
      "div":"SP1"
   },
   {  
      "season":"201617",
      "div":"SP2"
   }
]
```

### List matches 

Lists all the matches for a specific league (division and season pair).

```endpoint
GET /api/matches
```

#### Query string parameters

Name | Type | Required/Optional | Description
---|---|---|---
`season` | String | Required | The season.
`div` | String | Required | The division.
`type` | String | Optional | The format of the response. Available values are `json` and `protobuf`. If not specified, the value defaults to `json`.

#### Sample request

```curl
curl 'http://localhost/api/matches?season=201617&div=E0'
```

#### Sample response

```json
[  
   {  
      "season":"201617",
      "id":6431,
      "htr":"D",
      "hthg":0,
      "htag":0,
      "home_team":"Burnley",
      "ftr":"A",
      "fthg":0,
      "ftag":1,
      "div":"E0",
      "date":"2016-08-13",
      "away_team":"Swansea"
   },
   {  
      "season":"201617",
      "id":6432,
      "htr":"D",
      "hthg":0,
      "htag":0,
      "home_team":"Crystal Palace",
      "ftr":"A",
      "fthg":0,
      "ftag":1,
      "div":"E0",
      "date":"2016-08-13",
      "away_team":"West Brom"
   }
]
```
