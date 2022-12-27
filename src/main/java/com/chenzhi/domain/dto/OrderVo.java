package com.chenzhi.domain.dto;

import com.chenzhi.common.config.Enum.order.OrderStatusEnum;
import com.chenzhi.common.config.Enum.order.PaymentEnum;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class OrderVo {

    private Long orderId;


    /**
     * 联系人姓名1
     */
    private String myname1;

    /**
     * 市1
     */
    private String city1;

    /**
     * 省份1
     */
    private String province1;

    /**
     * 区1
     */
    private String region1;

    /**
     * 详细地址1
     */
    private String detailedAddress1;

    /**
     * 联系人姓名2
     */
    private String myname2;

    /**
     * 市2
     */
    private String city2;

    /**
     * 省份2
     */
    private String province2;

    /**
     * 区2
     */
    private String region2;

    /**
     * 详细地址2
     */
    private String detailedAddress2;


    /**
     * 网点名称1
     */
    private String WebsiteName1;

    /**
     * 网点名称2
     */
    private String WebsiteName2;

    /**
     * 货物名称
     */
    private String goodsNames;

    /**
     * 货物包装
     */
    private String goodsPack;

    /**
     * 件数
     */
    private Integer num;

    /**
     * 重量
     */
    private BigDecimal weigth;

    /**
     * 体积
     */
    private BigDecimal volume;

    /**
     * 备注
     */
    private String remark;

    /**
     * 0已撤销,1未受理，2已受理，3已开单，4已签收
     */
    private OrderStatusEnum orderStatus;

    /**
     * 下单时间
     */
    private Date createOrderTime;

    /**
     * 投保价值
     */
    private BigDecimal valueInsured;

    /**
     * 代收货款
     */
    private BigDecimal goodsPayment;

    /**
     * 付款方式
     */
    private PaymentEnum payment;
}
