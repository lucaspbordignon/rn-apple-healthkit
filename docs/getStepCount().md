Get the aggregated total steps for a specific day (starting and ending at midnight).

An optional options object may be provided containing `date` field representing the selected day. If `date` is not set or an options object is not provided then the current day will be used.
```javascript
let options = {
    date: new Date(2020, 1, 1).toISOString(), // optional
};
```

```javascript
AppleHealthKit.getStepCount(options: Object, (err: Object, results: Object) => {
    if (err) {
        return;
    }
    console.log(results)
});
```

```javascript
{
        "endDate": "2020-01-01T12:09:42.335+0800", 
        "startDate": "2020-01-01T08:14:45.467+0800"
	"value": 213,
}
```
