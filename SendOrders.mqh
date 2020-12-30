//+------------------------------------------------------------------+
//|                                                 SimpleTrades.mqh |
//|                                                   Abraão Moreira |
//|                                                abraaomoreira.com |
//+------------------------------------------------------------------+
#property copyright "Abraão Moreira"
#property link      "abraaomoreira.com"

#include <Trade/Trade.mqh>

enum TRADE_TYPE {
  SELL,
  BUY,
  NOTHING
};


class CSimpleTrades {
 public:
  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  void CSimpleTrades :: MarketOrderPoints(bool& m_requirements[],
                                          TRADE_TYPE m_tradeType,
                                          double m_volume,
                                          double m_takeProfit,
                                          double m_stopLoss) {
    for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
      if(m_requirements[i] == false)
        return;

    CTrade trade;
    double ask,
           bid;

    ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    if(m_tradeType == SELL) {
      trade.Sell(m_volume, NULL, bid, bid + m_stopLoss, bid - m_takeProfit);
    }
    if(m_tradeType == BUY) {
      trade.Buy(m_volume, NULL, ask, ask - m_stopLoss, ask + m_takeProfit);
    }
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  void CSimpleTrades :: StopOrder(bool& m_requirements[],
                                  TRADE_TYPE m_tradeType,
                                  double m_volume,
                                  double m_price,
                                  double m_takeProfit,
                                  double m_stopLoss) {
    for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
      if(m_requirements[i] == false)
        return;

    CTrade trade;

    if(m_tradeType == SELL) {
      trade.SellStop(m_volume, m_price, NULL, m_stopLoss, m_takeProfit);
    }
    if(m_tradeType == BUY) {
      trade.BuyStop(m_volume, m_price, NULL, m_stopLoss, m_takeProfit);
    }
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  void CSimpleTrades :: LimitOrder(bool& m_requirements[],
                                   TRADE_TYPE m_tradeType,
                                   double m_volume,
                                   double m_price,
                                   double m_takeProfit,
                                   double m_stopLoss) {
    for(int i = 0; i < ArrayRange(m_requirements, 0); i++)
      if(m_requirements[i] == false)
        return;

    CTrade trade;

    if(m_tradeType == SELL) {
      trade.SellLimit(m_volume, m_price, NULL, m_stopLoss, m_takeProfit);
    }
    if(m_tradeType == BUY) {
      trade.BuyLimit(m_volume, m_price, NULL, m_stopLoss, m_takeProfit);
    }
  }
};
//+------------------------------------------------------------------+
