Get the avg decibel level in a given date range

On success, the callback function will be provided with a `response` object containing the avg decibel `value`, and the `startDate` and `endDate` of the period where data was found.

```javascript
let startDate = new Date();
startDate.setDate(d.getDate() - 7); // Go back one week
let endDate = new Date();

let options = {
  startDate: startDate,
  endDate: endDate
};
```

```javascript
AppleHealthKit.getEnvironmentalAudioExposureLevelAvgForDateRange(options, (err: string, results: Object) => {
  if (err) {
    console.log("error getting avg decibel exposure levels: ", err);
    return;
  }
  console.log(results)
});
```

```javascript
{
	value: 59.723760982234,
	startDate: '2019-07-01T12:00:00.000-0400',
	endDate: '2019-07-08T12:00:00.000-0400'
}
```
