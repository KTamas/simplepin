import { Alert } from 'react-native'
import Storage from 'app/util/Storage'
import strings from 'app/style/strings'

export const logout = (navigation) => {
  Storage.clear()
  navigation.navigate('AuthLoading')
}

export const handleLoginResponseError = (error) => {
  switch (error) {
    case 401:
    case 500:
      return Alert.alert(
        strings.error.loginFailed,
        strings.error.incorrectToken,
      )
    default:
      return Alert.alert(
        strings.error.somethingWrong,
        strings.error.tryAgainLater,
      )
  }
}

export const handleResponseError = (error, navigation) => {
  switch (error) {
    case 401:
      return Alert.alert(
        strings.error.invalidToken,
        strings.error.logInAgain,
        [{ text: strings.common.ok, onPress: () => logout(navigation) }],
        { cancelable: false }
      )
    case 429:
      return Alert.alert(
        strings.error.tooManyRequests,
        strings.error.tryAgainLater,
      )
    case 500:
    case 503:
      return Alert.alert(
        strings.error.troubleConnecting,
        strings.error.pinboardDown,
      )
    default:
      return Alert.alert(
        strings.error.somethingWrong,
        strings.error.tryAgainLater,
      )
  }
}
