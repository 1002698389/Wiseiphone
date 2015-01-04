package com.wh.core;

import java.net.InetSocketAddress;
import org.apache.mina.core.future.ConnectFuture;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
import org.apache.mina.filter.logging.LoggingFilter;
import org.apache.mina.transport.socket.nio.NioSocketConnector;

import com.wh.customnet.VaCustomLogin;


public class MinaCient {
    private String ip;
    private int point;
    public static IoSession session;

    public MinaCient(String ip, int point) {
        this.ip = ip;
        this.point = point;
    }
    public static void main(String[] args) {
        new MinaCient("192.168.10.115", 9800).star();
    }
    public void star() {
        NioSocketConnector nkt = new NioSocketConnector();
        nkt.setConnectTimeoutMillis(5000);
        nkt.getFilterChain().addFirst("encoder", new ProtocolCodecFilter(new MycoderFactory()));
        nkt.getFilterChain().addLast("logger", new LoggingFilter());
        nkt.setHandler(new MyHandler());
        nkt.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, 30);
        ConnectFuture cf = nkt.connect(new InetSocketAddress(ip, point));
        cf.awaitUninterruptibly();
        if (cf.isDone()) {
            if (!cf.isConnected()) {
                System.out.print("¡¨Ω” ß∞‹!");
                cf.cancel();
                nkt.dispose();
            } else {
                session = cf.getSession();
            }
        }
    }
    public static IoSession getIosession(){
          if(session !=null){
              return session; 
          }
          return null;
    }
}
