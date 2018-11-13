import React from 'react'
import { StyleSheet, Text, Image, View, TouchableOpacity, FlatList } from 'react-native'
import PropTypes from 'prop-types'
import isEqual from 'lodash/isEqual'
import startsWith from 'lodash/startsWith'
import Base from 'app/assets/Base'

const Tag = ({ item }) => {
  const isPrivateTag = startsWith(item, '.')
  return(
    <TouchableOpacity
      activeOpacity={0.7}
      style={styles.tagContainer}
      onPress={() => console.log(item)}
    >
      <View style={[styles.tag, isPrivateTag && styles.privateTag]}>
        <Text style={[styles.tagText, isPrivateTag && styles.privateTagText]}>{item}</Text>
      </View>
    </TouchableOpacity>
  )
}

export default class PostCell extends React.Component {
  shouldComponentUpdate (nextProps, nextState) {
    return !isEqual(this.props, nextProps) || !isEqual(this.state, nextState)
  }

  render() {
    return (
      <TouchableOpacity
        activeOpacity={0.7}
        onPress={() => console.log(this.props.item)}
      >
        {
          this.props.item.toread
          ? <View style={styles.unread} />
          : null
        }
        {
          !this.props.item.shared
          ? <Image source={require('app/assets/ic-lock.png')} style={styles.private} />
          : null
        }
        <Text style={[styles.title, this.props.item.toread && styles.titleUnread]}>{this.props.item.description}</Text>
        {
          this.props.item.extended
          ? <Text style={styles.description}>{this.props.item.extended.trim()}</Text>
          : null
        }
        <FlatList
          bounces={false}
          data={this.props.item.tags}
          horizontal={true}
          keyExtractor={(item, index) => index.toString()}
          ListEmptyComponent={() => <View style={styles.emptyTagList} />}
          renderItem={({ item }) => <Tag item={item} />}
          showsHorizontalScrollIndicator={false}
          style={styles.tagList}
        />
        <Text style={styles.time}>{this.props.item.time.toLocaleDateString()}</Text>
      </TouchableOpacity>
    )
  }
}

PostCell.propTypes = {
  item: PropTypes.shape({
    description: PropTypes.string.isRequired,
    extended: PropTypes.string,
    hash: PropTypes.string.isRequired,
    href: PropTypes.string.isRequired,
    meta: PropTypes.string.isRequired,
    shared: PropTypes.bool.isRequired,
    tags: PropTypes.array,
    time: PropTypes.object.isRequired,
    toread: PropTypes.bool.isRequired,
  }),
}

const styles = StyleSheet.create({
  unread: {
    backgroundColor: Base.colors.blue2,
    borderRadius: 5,
    height: 9,
    left: 8,
    position: 'absolute',
    top: 20,
    width: 9,
  },
  private: {
    bottom: Base.padding.medium,
    height: 16,
    position: 'absolute',
    right: Base.padding.medium,
    tintColor: Base.colors.gray2,
    width: 16,
  },
  title: {
    color: Base.colors.gray4,
    fontSize: Base.fonts.large,
    lineHeight: 24,
    paddingTop: 12,
    paddingLeft: Base.padding.large,
    paddingRight: Base.padding.medium,
  },
  titleUnread: {
    fontWeight: Base.fonts.bold,
  },
  description: {
    color: Base.colors.gray3,
    fontSize: Base.fonts.medium,
    lineHeight: 20,
    paddingTop: Base.padding.tiny,
    paddingLeft: Base.padding.large,
    paddingRight: Base.padding.medium,
  },
  time: {
    color: Base.colors.gray3,
    fontSize: Base.fonts.medium,
    lineHeight: 20,
    paddingBottom: 14,
    paddingLeft: Base.padding.large,
    paddingRight: Base.padding.medium,
  },
  emptyTagList: {
    height: 5,
  },
  tagList: {
    marginLeft: Base.padding.large - Base.padding.tiny,
    marginRight: Base.padding.tiny,
    overflow: 'visible',
  },
  tagContainer: {
    paddingHorizontal: Base.padding.tiny,
    paddingVertical: Base.padding.small,
  },
  tag: {
    backgroundColor: Base.colors.blue1,
    borderRadius: Base.radius.small,
    paddingHorizontal: Base.padding.small,
    paddingVertical: Base.padding.tiny,
  },
  tagText: {
    color: Base.colors.blue2,
    lineHeight: 16,
  },
  privateTag: {
    backgroundColor: Base.colors.gray1,
  },
  privateTagText: {
    color: Base.colors.gray3,
  },
})