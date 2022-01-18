/// <reference types="howler"/>
/// <reference types="jquery"/>

'use strict';

var player = new Howl({ src: ['./beep.wav'] }),
  serial = '6039',
  keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

for (var i = 0; i < 4; i++) {
  serial += keys.charAt(Math.floor(Math.random() * keys.length));
}
setInterval(() => {
  const now = new Date();
  let offset = now.getTimezoneOffset() / -60;
  now.setTime(now.getTime() + offset * 60);
  if (
    now.getTimezoneOffset() <
    Math.max(
      new Date(now.getFullYear(), 0, 1).getTimezoneOffset(),
      new Date(now.getFullYear(), 6, 1).getTimezoneOffset(),
    )
  ) {
    offset += 1;
  }
  const iso = new Date(now.getTime() + offset * 36e5).toISOString();
  $('#date').text(
    `${iso.substring(0, 10)} ${iso.substring(11, 19)} ${offset < 0 ? '-' : '+'}${Math.abs(offset)
      .toString()
      .padEnd(3, '0')
      .padStart(4, '0')}`,
  );
}, 1e3);

$(() => {
  window.addEventListener('message', event => {
    if ('AxonUIPresence' in event.data) {
      $('#ui').css('display', event.data.AxonUIPresence ? 'block' : 'none');
    }

    if ('AxonBeep' in event.data) {
      player.volume(event.data.AxonBeep.volume);
      player.play();
    }
  });
  $('#text').text(`AXON BODY 3 X${serial}`);
});
