package com.chenzhi.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chenzhi.common.config.Enum.order.OrderStatusEnum;
import com.chenzhi.common.utils.Result;
import com.chenzhi.domain.dto.OrderVo;
import com.chenzhi.domain.entity.SysAddress;
import com.chenzhi.domain.entity.SysOrder;
import com.chenzhi.domain.entity.SysWebsite;
import com.chenzhi.mapper.SysAddressMapper;
import com.chenzhi.mapper.SysWebsiteMapper;
import com.chenzhi.service.SysOrderService;
import com.chenzhi.mapper.SysOrderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
* @author 86199
* @description 针对表【sys_order】的数据库操作Service实现
* @createDate 2022-12-18 19:35:56
*/
@Service
public class SysOrderServiceImpl extends ServiceImpl<SysOrderMapper, SysOrder>
        implements SysOrderService{

    @Resource
    private SysOrderMapper sysOrderMapper;
    @Resource
    private SysAddressMapper sysAddressMapper;

    @Resource
    private SysWebsiteMapper sysWebsiteMapper;

    //获取个人所有的订单
    @Override
    public Result getAllOrders(Long userId) {
        LambdaQueryWrapper<SysOrder> sysAddressQueryWrapper = new LambdaQueryWrapper<>();
        sysAddressQueryWrapper.eq(SysOrder::getUserId,userId);
        List<SysOrder> sysOrderList= sysOrderMapper.selectList(sysAddressQueryWrapper);
        if(sysOrderList.size()==0)
            Result.success(400,"个人所有的订单为空！",null);
        //创建OrderVo数组
        List<OrderVo> orderVoList = new ArrayList<>(sysOrderList.size());
        for (SysOrder sysOrder : sysOrderList) {
            //发送的地址薄
            SysAddress sysSentAddress = sysAddressMapper.selectById(sysOrder.getSendId());
            //接收的地址薄
            SysAddress sysCollectAddress = sysAddressMapper.selectById(sysOrder.getCollectId());
            //起始网点
            SysWebsite sysStartWebsite = sysWebsiteMapper.selectById(sysOrder.getStartnetdot());
            //到达网点
            SysWebsite sysEndWebsite = sysWebsiteMapper.selectById(sysOrder.getEndnetdot());
            OrderVo orderVo = new OrderVo();
            //开始初始化
            orderVo.setOrderId(sysOrder.getOrderId());

            orderVo.setMyname1(sysSentAddress.getMyname());
            orderVo.setProvince1(sysSentAddress.getProvince());
            orderVo.setCity1(sysSentAddress.getCity());
            orderVo.setRegion1(sysSentAddress.getRegion());
            orderVo.setDetailedAddress1(sysSentAddress.getDetailedAddress());

            orderVo.setMyname2(sysCollectAddress.getMyname());
            orderVo.setProvince2(sysCollectAddress.getProvince());
            orderVo.setCity2(sysCollectAddress.getCity());
            orderVo.setRegion2(sysCollectAddress.getRegion());
            orderVo.setDetailedAddress2(sysCollectAddress.getDetailedAddress());

            orderVo.setWebsiteName1(sysStartWebsite.getWebsiteName());
            orderVo.setWebsiteName2(sysEndWebsite.getWebsiteName());

            orderVo.setGoodsNames(sysOrder.getGoodsNames());
            orderVo.setGoodsPack(sysOrder.getGoodsPack());
            orderVo.setNum(sysOrder.getNum());
            orderVo.setWeigth(sysOrder.getWeigth());
            orderVo.setVolume(sysOrder.getVolume());
            orderVo.setRemark(sysOrder.getRemark());
            orderVo.setOrderStatus(sysOrder.getOrderStatus());
            orderVo.setCreateOrderTime(sysOrder.getCreateOrderTime());
            orderVo.setValueInsured(sysOrder.getValueInsured());
            orderVo.setGoodsPayment(sysOrder.getGoodsPayment());
            orderVo.setPayment(sysOrder.getPayment());
            orderVoList.add(orderVo);
        }
        return Result.success(200,"获取个人所有的订单成功！",orderVoList);
    }


    //新增订单
    @Override
    public Result addOrder(SysOrder sysOrder) {
        sysOrder.setCreateOrderTime(new Date());
        int insert = sysOrderMapper.insert(sysOrder);
        if (insert>0)
            return Result.success(200,"新增订单成功！",null);
        return Result.fail(400,"新增订单失败！" ,null);
    }

    //修改订单状态
    @Override
    public Result updateOrder(Long orderId) {
        SysOrder sysOrder = sysOrderMapper.selectById(orderId);
        //当前系统的时间毫秒值
        long currentTime = new Date().getTime();
        //创建订单的时间毫秒值
        long createOrderTime = sysOrder.getCreateOrderTime().getTime();
        //如果订单状态是未受理的 且 创建的订单的时间不超过45秒
        if(sysOrder.getOrderStatus()==OrderStatusEnum.NotAccepted&&currentTime-createOrderTime<=45000){
            sysOrder.setOrderStatus(OrderStatusEnum.Withdrawn);
            sysOrderMapper.updateById(sysOrder);
            return Result.success(200,"修改订单状态成功！",null);
        }
        return Result.fail(400,"修改订单状态失败！",null);
    }
}





