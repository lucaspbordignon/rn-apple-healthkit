Get the list of Bloating Samples within given dates.

```javascript
let options = {
  startDate?: Date,
  endDate?: Date,
  limit?: number
};
```

```javascript
AppleHealthKit.getBloatingSamples(options, (err: string, results: Object) => {
  if (err) {
    console.log("error getting bloating samples: ", err);
    return;
  }
  // returns array of bloating samples
  console.log(results);
});
```

```javascript
[
  {
    startDate: "2016-07-08T12:00:00.000-0400",
    endDate: "2016-07-08T12:00:00.000-0400"
  },
  {
    startDate: "2016-07-08T12:00:00.000-0400",
    endDate: "2016-07-08T12:00:00.000-0400"
  }
];
```
