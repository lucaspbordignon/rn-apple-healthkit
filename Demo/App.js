/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
} from 'react-native';

import AppleHealthKit from 'rn-apple-healthkit';
const PERMS = AppleHealthKit.Constants.Permissions;

export class App extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      Weight: false,
      Height: false,
      DateOfBirth: false,
    };
  }

  componentDidMount() {
    const healthKitOptions = {
        permissions: {
            read:  [
                PERMS.DateOfBirth,
                PERMS.Weight,
            ]
        }
    };

    AppleHealthKit.initHealthKit(healthKitOptions, (err, results) => {
      if (err) {
        console.log("error initializing Healthkit: ", err);
        return;
      }

      // Date of Birth Example
      AppleHealthKit.getDateOfBirth(null, (err, results) => {
        this.setState({
          DateOfBirth: results
        })
      });

      // Get Latest Weight
      AppleHealthKit.getLatestWeight(null, (err: string, results: Object) => {
        this.setState({
          Weight: results
        })
      });

    });

  }

  render() {
    const {
      DateOfBirth,
      Weight
    } = this.state;

    return (
      <View>
        <StatusBar barStyle="dark-content" />
        <SafeAreaView>
          <ScrollView
            contentInsetAdjustmentBehavior="automatic"
            style={styles.scrollView}>
            <View style={styles.body}>
              <View style={styles.sectionContainer}>
                <Text style={styles.sectionTitle}>Weight</Text>
                {(Weight) &&
                  <Text style={styles.sectionDescription}>
                  {Weight.value}
                  </Text>
                }
                {(!Weight) &&
                  <Text style={styles.sectionDescriptionError}>
                  Add your Weight to Health App!
                  </Text>
                }
              </View>
              <View style={styles.sectionContainer}>
                <Text style={styles.sectionTitle}>Age</Text>
                {(DateOfBirth) &&
                  <Text style={styles.sectionDescription}>
                  {DateOfBirth.age}
                  </Text>
                }
                {(!DateOfBirth) &&
                  <Text style={styles.sectionDescriptionError}>
                  Add your Birthday to Health App!
                  </Text>
                }
              </View>
            </View>
          </ScrollView>
        </SafeAreaView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: '#FFF',
  },
  body: {
    backgroundColor: '#FFF',
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: '#000',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: '#555',
  },
  sectionDescriptionError: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: '#A00000'
  },
});

export default App;
