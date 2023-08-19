//
//  ordersByUser.swift
//  Coffes Bar
//
//  Created by kenjimaeda on 18/08/23.
//

import Foundation

let ordersByUserMock: [OrdersByUserModel] = [
  OrdersByUserModel(
    id: "64d3847f106302ae76bef725",
    orders: [
      Orders(
        id: "64d0d735d545e3b60f6be839",
        title: "Pingado",
        price: "R$ 6,00",
        quantity: 3,
        urlImage: "https://cdn.abrahao.com.br/base/f4d/0e2/e7f/pingado.jpg"
      ),
      Orders(
        id: "d0d782cc315bcb623ed940",
        title: "Latte",
        price: "R$ 14,00",
        quantity: 4,
        urlImage: "https://cdn.abrahao.com.br/base/f50/c70/35e/latte.jpg"
      ),
      Orders(
        id: "64d3847f106302ae76befsf5sf726",
        title: "Bebida aleatoria",
        price: "R$ 6,30",
        quantity: 7,
        urlImage: "https://cdn.abrahao.com.br/base/fa7/518/562/espresso.jpg"
      )
    ],
    priceCartTotal: "R$14,00",
    tax: "R$2,00",
    userId: "64d2c46cc5e48e0957f5c196"
  ),
  OrdersByUserModel(
    id: "64d3847f10630sas3w2ae76bef725",
    orders: [
      Orders(
        id: "64d3847f106302ae7fs5434236bef726",
        title: "Bebida aleatoria",
        price: "R$ 6,30",
        quantity: 3,
        urlImage: "https://cdn.abrahao.com.br/base/fa7/518/562/espresso.jpg"
      ),
      Orders(
        id: "64d0d7622724facc9ec2",
        title: "Bebida aleatoria",
        price: "R$ 6,30",
        quantity: 4,
        urlImage: "https://cdn.abrahao.com.br/base/fa7/518/562/espresso.jpg"
      ),
      Orders(
        id: "64d0d8404efdc5abe2835",
        title: "Bebida aleatoria",
        price: "R$ 6,30",
        quantity: 7,
        urlImage: "https://cdn.abrahao.com.br/base/fa7/518/562/espresso.jpg"
      )
    ],
    priceCartTotal: "R$14,00",
    tax: "R$2,00",
    userId: "64d2c46cc5e48e0957f5c196"
  )
]
