import React from 'react'
import { StyleSheet, Modal, TouchableOpacity, View, Text, Animated, Dimensions } from 'react-native'
import { getBottomSpace } from 'react-native-iphone-x-helper'
import PropTypes from 'prop-types'
import Base from 'app/style/Base'
import Strings from 'app/style/Strings'

const AnimatedTouchableOpacity = Animated.createAnimatedComponent(TouchableOpacity)

export default class BottomSheet extends React.PureComponent {
  constructor() {
    super(...arguments)
    this.state = { visible: this.props.visible }
    this.animation = new Animated.Value(0)
    this.overlayStyle = StyleSheet.flatten([styles.overlay, { opacity: this.animation }])
    this.contentStyle = StyleSheet.flatten([styles.content, {
      transform: [{
        translateY: this.animation.interpolate({
          inputRange: [0, 1],
          outputRange: [Dimensions.get('screen').height, 0],
          extrapolate: 'clamp',
        }),
      }],
    }])
    if (this.props.visible) this.animate(1)
  }

  componentDidUpdate(prevProps) {
    if (!prevProps.visible && this.props.visible) {
      this.setState({ visible: true }, () => {
        this.animate(1)
      })
    } else if (prevProps.visible && !this.props.visible) {
      this.animate(0, () => {
        this.setState({ visible: false })
      })
    }
  }

  animate = (toValue, callback) => {
    Animated.timing(this.animation, {
      toValue,
      duration: 300,
      useNativeDriver: true,
    }).start(callback)
  }

  render() {
    const { post } = this.props
    const toread = post.toread ? 'read' : 'unread'
    return (
      <Modal
        animationType="none"
        visible={this.state.visible}
        transparent={true}
        onRequestClose={this.props.onClose}
        hardwareAccelerated={true}
        supportedOrientations={['portrait', 'landscape']}
      >
        <View style={styles.root}>
          <AnimatedTouchableOpacity
            activeOpacity={1}
            onPress={this.props.onClose}
            style={this.overlayStyle}
          />
          <Animated.View style={this.contentStyle}>
            <View style={styles.cell}>
              <Text
                style={styles.title}
                numberOfLines={1}
                ellipsizeMode="tail"
              >
                {post.description}
              </Text>
            </View>
            <TouchableOpacity
              activeOpacity={0.5}
              style={styles.cell}
              onPress={this.props.onToggleToread(post)}
            >
              <Text style={styles.text}>{Strings.common.markAs} {toread}</Text>
            </TouchableOpacity>
            <TouchableOpacity
              activeOpacity={0.5}
              style={styles.cell}
              onPress={this.props.onEditPost(post)}
            >
              <Text style={styles.text}>{Strings.common.edit}</Text>
            </TouchableOpacity>
            <TouchableOpacity
              activeOpacity={0.5}
              style={styles.cell}
              onPress={this.props.onDeletePost(post)}
            >
              <Text style={styles.text}>{Strings.common.delete}</Text>
            </TouchableOpacity>
            <TouchableOpacity
              activeOpacity={0.5}
              style={styles.cell}
              onPress={this.props.onClose}
            >
              <Text style={styles.text}>{Strings.common.cancel}</Text>
            </TouchableOpacity>
          </Animated.View>
        </View>
      </Modal>
    )
  }
}

BottomSheet.propTypes = {
  visible: PropTypes.bool.isRequired,
  onClose: PropTypes.func.isRequired,
  onToggleToread: PropTypes.func.isRequired,
  onEditPost: PropTypes.func.isRequired,
  onDeletePost: PropTypes.func.isRequired,
  post: PropTypes.object.isRequired,
}

const styles = StyleSheet.create({
  root: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'flex-end',
    alignItems: 'center',
  },
  overlay: {
    position: 'absolute',
    top: 0, left: 0, right: 0, bottom: 0,
    backgroundColor: Base.color.black36,
  },
  content: {
    width: '100%',
    flexDirection: 'column',
    backgroundColor: Base.color.white,
    borderTopLeftRadius: Base.radius.large,
    borderTopRightRadius: Base.radius.large,
    elevation: 8,
    paddingBottom: Math.max(getBottomSpace(), Base.padding.small),
    paddingTop: Base.padding.small,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0.15,
    shadowRadius: 4,
  },
  cell: {
    alignItems: 'center',
    flexDirection: 'row',
    height: Base.row.large,
    paddingHorizontal: Base.padding.medium,
  },
  text: {
    color: Base.color.gray4,
    fontSize: Base.font.large,
  },
  title: {
    color: Base.color.gray3,
    fontSize: Base.font.medium,
    marginTop: Base.padding.tiny,
  },
})
