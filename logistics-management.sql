/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : logistics-management

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 27/12/2022 17:08:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_address
-- ----------------------------
DROP TABLE IF EXISTS `sys_address`;
CREATE TABLE `sys_address`  (
  `address_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址薄id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `myname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人姓名',
  `detailed_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址',
  `phone_number` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `code` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省市区号码',
  `collect_orsend` int(11) NOT NULL COMMENT '收发货人；1发货人，2为收货人',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1为默认地址，0为非默',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '市',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份',
  `region` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_address
-- ----------------------------
INSERT INTO `sys_address` VALUES (29, 1, '大治', '远在天边', '19974077529', '360924', 1, 1, '宜春市', '江西省', '宜丰县');
INSERT INTO `sys_address` VALUES (30, 1, '小治', '湖南工程学院', '19974077529', '430304', 2, 1, '湘潭市', '湖南省', '岳塘区');

-- ----------------------------
-- Table structure for sys_cargo
-- ----------------------------
DROP TABLE IF EXISTS `sys_cargo`;
CREATE TABLE `sys_cargo`  (
  `cargo_id` bigint(20) NOT NULL,
  `goods_names` enum('日用品','家用家电','数码产品','食品饮料','设备及材料','服装鞋帽','其他') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goods_pack` enum('包装袋','裸装','膜','木架','纤袋','信封') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `send_goods_type` enum('自提','送货上门','送货上楼') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发货类别',
  `return_slip` enum('不签回单','原件返回','传真返回') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代签回单',
  PRIMARY KEY (`cargo_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_cargo
-- ----------------------------

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order`  (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `send_id` bigint(20) NOT NULL COMMENT '地址薄ID-发货',
  `collect_id` bigint(20) NOT NULL COMMENT '地址薄ID-收货',
  `startnetdot` bigint(20) NOT NULL COMMENT '网点Id-1',
  `endnetdot` bigint(20) NOT NULL COMMENT '网点Id-2',
  `goods_names` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货物名称',
  `goods_pack` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货物包装',
  `num` int(11) NOT NULL COMMENT '件数',
  `weigth` decimal(6, 2) NOT NULL COMMENT '重量',
  `volume` decimal(6, 2) NOT NULL COMMENT '体积',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `order_status` tinyint(4) NULL DEFAULT NULL COMMENT '0,已撤销1未受理，2已受理，3已开单，4已签收',
  `create_order_time` timestamp NULL DEFAULT NULL COMMENT '下单时间',
  `value_insured` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '投保价值',
  `goods_payment` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '代收货款',
  `payment` tinyint(4) NOT NULL COMMENT '付款方式1到付，2现付，',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_order
-- ----------------------------
INSERT INTO `sys_order` VALUES (4, 1, 29, 30, 2, 1, '食品饮料', '裸装', 1, 2.00, 3.00, '这是备注', 1, '2022-12-22 16:05:45', 0.00, 0.00, 2);
INSERT INTO `sys_order` VALUES (5, 1, 29, 30, 2, 1, '数码产品', '膜', 6, 7.00, 8.00, '这是备注2', 1, '2022-12-22 16:06:53', 2.00, 6.00, 1);
INSERT INTO `sys_order` VALUES (6, 1, 29, 30, 2, 1, '数码产品', '膜', 6, 7.00, 8.00, '这是备注2', 1, '2022-12-22 16:09:08', 2.00, 6.00, 2);
INSERT INTO `sys_order` VALUES (7, 1, 29, 30, 2, 1, '数码产品', '膜', 6, 7.00, 8.00, '这是备注2', 0, '2022-12-22 21:04:32', 2.00, 6.00, 2);
INSERT INTO `sys_order` VALUES (8, 1, 29, 30, 2, 1, '数码产品', '膜', 6, 7.00, 8.00, '这是备注2', 1, '2022-12-22 21:09:40', 2.00, 6.00, 2);
INSERT INTO `sys_order` VALUES (9, 1, 29, 30, 2, 1, '数码产品', '膜', 6, 7.00, 8.00, '这是备注2', 1, '2022-12-22 21:34:09', 2.00, 6.00, 2);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `money` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '余额',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '19974077529', 'https://ts1.cn.mm.bing.net/th?id=OIP-C.ZrPv3yd1CLjJqcR92cFOSwHaHb&w=249&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2', '{noop}123456', '如约而至', 0.00);
INSERT INTO `sys_user` VALUES (4, '19967292567', 'http://rmvft83aq.hn-bkt.clouddn.com/99d276f8-d98b-41fa-ab40-acc2420b2b3e', '{noop}123456', '大峰哥', 0.00);
INSERT INTO `sys_user` VALUES (5, '13333333333', 'http://rmvft83aq.hn-bkt.clouddn.com/99d276f8-d98b-41fa-ab40-acc2420b2b3e', '{noop}123456', '大治', 0.00);

-- ----------------------------
-- Table structure for sys_website
-- ----------------------------
DROP TABLE IF EXISTS `sys_website`;
CREATE TABLE `sys_website`  (
  `website_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '网点id',
  `website_province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网点省份',
  `website_city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网点市',
  `website_region` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网点区',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机',
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话（座机）',
  `detailed_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址',
  `category` tinyint(4) NOT NULL COMMENT '送货类别',
  `code` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省市区码',
  `website_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网点名称',
  PRIMARY KEY (`website_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_website
-- ----------------------------
INSERT INTO `sys_website` VALUES (1, '湖南省', '湘潭市', '岳塘区', '19974077529', '0795-66666666', '福星中路88号', 1, '010101', '湘潭网点');
INSERT INTO `sys_website` VALUES (2, '江西省', '宜春市', '铜鼓县', '19974077529', '8888-88888888', '天涯海角', 2, '020202', '宜春网点');

SET FOREIGN_KEY_CHECKS = 1;
