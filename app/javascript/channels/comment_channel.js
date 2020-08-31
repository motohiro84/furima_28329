import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<div class="comment-sentence" >
                  <div class="comment-view">
                  <strong>
                  <a href=“#”>${data.nickname}</a>：
                  </strong>${data.content.text}
                  </div>
                  <div class="comment-time">
                  ${data.created_at}
                  </div>
                  </div>`;
    console.log(data)
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');
    comments.insertAdjacentHTML('beforeend', html);
    newComment.value='';  }
});