Query for nurition samples. the options object is used to setup a query to retrieve relevant samples.

Anyone can add more nutrition in ```RCTAppleHealthKit+Methods_Dietary.m getNutritionSamples``` function using ```HKQuantityType```
[Health-Kit Quantity type identifiers](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier?language=objc)

```javascript
let options = {
  unit: 'liter', // current nutrition water, therefore use 'liter'
  type: 'Water', // current nutrition water
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthKit.getNutritionSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
// TODO: update 
  { value: 160, startDate: '2016-07-09T00:00:00.000-0400', endDate: '2016-07-10T00:00:00.000-0400' },
  { value: 161, startDate: '2016-07-08T00:00:00.000-0400', endDate: '2016-07-09T00:00:00.000-0400' },
  { value: 165, startDate: '2016-07-07T00:00:00.000-0400', endDate: '2016-07-08T00:00:00.000-0400' },
]
```
