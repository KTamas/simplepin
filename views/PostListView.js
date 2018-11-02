import _ from 'lodash'
import React from 'react'
import {StyleSheet, FlatList, RefreshControl, TouchableOpacity, Image, Text} from 'react-native'
import Api from 'app/Api'
import Storage from 'app/util/Storage'
import PostListItem from 'app/views/PostListItem'
import MenuButton from 'app/components/MenuButton'
import {colors} from 'app/assets/base'
import strings from 'app/assets/strings'

const reviver = (key, value) => {
  switch (key) {
    case 'shared':
      return value == 'yes'
    case 'toread':
      return value == 'yes'
    case 'time':
      return new Date(value)
    case 'tags':
      return value !== '' ? value.split(' ') : null
    default:
      return value
  }
}

export default class PostListView extends React.Component {
  static navigationOptions = ({navigation}) => {
    return {
      title: navigation.getParam('title', strings.menu.all),
      headerLeft: (
        <MenuButton navigation={navigation} />
      )
    }
  }

  constructor(props) {
    super(props)
    this.state = {
      allPosts: null,
      unreadPosts: null,
      privatePosts: null,
      publicPosts: null,
      refreshing: false,
      lastUpdateTime: null,
    }
  }

  componentDidMount() {
    // TODO: open app, goto settings, go to public, app goes to all
    this.onRefresh()
  }

  onRefresh = async () => {
    this.setState({refreshing: true})
    const hasUpdates = await this.checkForUpdates()
    hasUpdates && await this.fetchPosts()
    this.setState({refreshing: false})
  }

  checkForUpdates = async () => {
    const apiToken = await Storage.apiToken()
    const response = await Api.update(apiToken)
    if (response.ok == 0) {
      console.warn(response.error)
    } else {
      if (response.update_time !== this.state.lastUpdateTime) {
        this.setState({'lastUpdateTime': response.update_time})
        return true
      }
      return false
    }
  }

  fetchPosts = async () => {
    const apiToken = await Storage.apiToken()
    const response = await Api.mockPosts(apiToken)
    if(response.ok === 0) {
      console.warn(response.error)
    } else {
      const str = JSON.stringify(response)
      const obj = JSON.parse(str, reviver)
      this.setState({
        allPosts: obj,
        unreadPosts: _.filter(obj, ['toread', true]),
        privatePosts: _.filter(obj, ['shared', false]),
        publicPosts: _.filter(obj, ['shared', true]),
      })
      Storage.setPostCount({
        all: this.state.allPosts.length,
        unread: this.state.unreadPosts.length,
        private: this.state.privatePosts.length,
        public: this.state.publicPosts.length,
      })
    }
  }

  filterPosts = () => {
    const predicate = this.props.navigation.getParam('title', '')
    switch (predicate) {
      case strings.menu.unread:
        return this.state.unreadPosts
      case strings.menu.private:
        return this.state.privatePosts
      case strings.menu.public:
        return this.state.publicPosts
      default:
        return this.state.allPosts
    }
  }

  render() {
    return (
      <FlatList
        data={this.filterPosts()}
        initialNumToRender={8}
        keyExtractor={(item, index) => index.toString()}
        ListEmptyComponent={null}
        renderItem={({item}) => <PostListItem item={item} />}
        style={styles.container}
        refreshControl={
          <RefreshControl
            refreshing={this.state.refreshing}
            onRefresh={this.onRefresh}
          />
        }
      />
    )
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: colors.white,
  }
})