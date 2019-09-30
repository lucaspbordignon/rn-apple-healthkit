Query for audio exposure samples. the options object is used to setup a query to retrieve relevant samples in dBA.

```javascript
let options = {
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthKit.getEnvironmentalAudioExposureLevelSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
    { "value": 58.39692158858813, "startDate": "2019-09-30T17:32:56.038-0400", "endDate": "2019-09-30T18:02:56.037-0400" },
    { "value": 62.79403852846269, "startDate": "2019-09-30T17:02:56.038-0400", "endDate": "2019-09-30T17:32:56.038-0400" },
    { "value": 57.04074046527535, "startDate": "2019-09-30T16:32:56.040-0400", "endDate": "2019-09-30T17:02:56.038-0400" },
    { "value": 66.33156995362445, "startDate": "2019-09-30T16:03:00.829-0400", "endDate": "2019-09-30T16:32:56.039-0400" },
]
```
