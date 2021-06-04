// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

import "bootstrap/dist/js/bootstrap.bundle"
global.toastr = require("toastr")

global.axios = require("axios")
axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name=csrf-token]').content
axios.defaults.headers.common['Accept'] = 'application/json'
axios.defaults.baseURL = window.location.origin

document.addEventListener("turbolinks:load", function() {
  document.querySelectorAll('i.fa-heart[dataid]').forEach(item => {
    item.addEventListener('click', (e) => {
      if (e.target.classList.contains('liked')) {
        unlikePost(e)
      } else {
        likePost(e)
      }
    })
  })

  document.querySelectorAll('i.fa-bookmark[dataid]').forEach(item => {
    item.addEventListener('click', (e) => {
      if (e.target.classList.contains('far')) {
        savePost(e)
      } else {
        unsavePost(e)
      }
    })
  })
})

function likePost(e) {
  axios.post(`/posts/${e.target.getAttribute('dataid')}/post_likes`).then(res => {
    if (res.data.id != null) {
      e.target.classList.remove('far')
      e.target.classList.add('fas')
      e.target.classList.remove('text-dark')
      e.target.classList.add('liked')
      e.target.setAttribute('likeid', res.data.id)
      changeLikeCount(e.target.getAttribute('dataid'), res.data.likes)
    }
  }).catch(err => {
    toastr.error('Something went wrong!')
  })
}

function unlikePost(e) {
  axios.delete(`/posts/${e.target.getAttribute('dataid')}/post_likes/${e.target.getAttribute('likeid')}`).then(res => {
    if (res.data.status) {
      e.target.classList.add('far')
      e.target.classList.remove('fas')
      e.target.classList.add('text-dark')
      e.target.classList.remove('liked')
      e.target.removeAttribute('likeid')
      changeLikeCount(e.target.getAttribute('dataid'), res.data.likes)
    }
  }).catch(err => {
    toastr.error('Something went wrong!')
  })
}

function changeLikeCount(id, count) {
  document.querySelector(`.like-count[dataid="${id}"]`).innerHTML = count + " likes"
}

function savePost(e) {
  axios.post(`/posts/${e.target.getAttribute('dataid')}/saved_posts`).then(res => {
    if (res.data.id != null) {
      e.target.classList.remove('far')
      e.target.classList.add('fas')
      e.target.setAttribute('saveid', res.data.id)
    }
  }).catch(err => {
    toastr.error('Something went wrong!')
  })
}

function unsavePost(e) {
  axios.delete(`/posts/${e.target.getAttribute('dataid')}/saved_posts/${e.target.getAttribute('saveid')}`).then(res => {
    if (res.data.status) {
      e.target.classList.add('far')
      e.target.classList.remove('fas')
      e.target.removeAttribute('saveid')
    }
  }).catch(err => {
    toastr.error('Something went wrong!')
  })
}

import "controllers"
