-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_productClass` (
  `classId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别id',
  `className` varchar(20)  NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500)  NOT NULL COMMENT '类别描述',
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `productClassObj` int(11) NOT NULL COMMENT '商品类别',
  `productName` varchar(50)  NOT NULL COMMENT '商品名称',
  `mainPhoto` varchar(60)  NOT NULL COMMENT '商品主图',
  `price` float NOT NULL COMMENT '商品价格',
  `productDesc` varchar(5000)  NOT NULL COMMENT '商品描述',
  `userObj` varchar(30)  NOT NULL COMMENT '发布用户',
  `addTime` varchar(20)  NULL COMMENT '发布时间',
  `sksp` varchar(60)  NOT NULL COMMENT '试看视频',
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_shopCart` (
  `cartId` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `productObj` int(11) NOT NULL COMMENT '商品',
  `userObj` varchar(30)  NOT NULL COMMENT '用户',
  `price` float NOT NULL COMMENT '单价',
  `buyNum` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`cartId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_orderInfo` (
  `orderNo` varchar(30)  NOT NULL COMMENT 'orderNo',
  `userObj` varchar(30)  NOT NULL COMMENT '下单用户',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `payWay` varchar(20)  NOT NULL COMMENT '支付方式',
  `orderStateObj` varchar(20)  NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20)  NULL COMMENT '下单时间',
  `receiveName` varchar(20)  NOT NULL COMMENT '收货人',
  `telephone` varchar(20)  NOT NULL COMMENT '收货人电话',
  `address` varchar(80)  NOT NULL COMMENT '收货地址',
  `orderMemo` varchar(500)  NULL COMMENT '订单备注',
  `sellObj` varchar(30)  NOT NULL COMMENT '商家',
  PRIMARY KEY (`orderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_orderItem` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT '条目id',
  `orderObj` varchar(30)  NOT NULL COMMENT '所属订单',
  `productObj` int(11) NOT NULL COMMENT '订单商品',
  `price` float NOT NULL COMMENT '商品单价',
  `orderNumer` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_comment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `productObj` int(11) NOT NULL COMMENT '被评商品',
  `content` varchar(1000)  NOT NULL COMMENT '评论内容',
  `userObj` varchar(30)  NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20)  NULL COMMENT '评论时间',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_product ADD CONSTRAINT FOREIGN KEY (productClassObj) REFERENCES t_productClass(classId);
ALTER TABLE t_product ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_shopCart ADD CONSTRAINT FOREIGN KEY (productObj) REFERENCES t_product(productId);
ALTER TABLE t_shopCart ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_orderInfo ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_orderInfo ADD CONSTRAINT FOREIGN KEY (sellObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_orderItem ADD CONSTRAINT FOREIGN KEY (orderObj) REFERENCES t_orderInfo(orderNo);
ALTER TABLE t_orderItem ADD CONSTRAINT FOREIGN KEY (productObj) REFERENCES t_product(productId);
ALTER TABLE t_comment ADD CONSTRAINT FOREIGN KEY (productObj) REFERENCES t_product(productId);
ALTER TABLE t_comment ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


