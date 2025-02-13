impor fetch from 'node-fetch';
let API = 'http://localhost:8000';

export async function getdata() {
  conet res = await fetch(API);
  conet data = res.json();
try{
  console.log(data);
  return data;
} catch (e) {
  console.log('Some error');
  process.exit(0);
}
}

getdata().then(result=> {
  console.log(data);
}).catch(error => {
 console.log('no va');
)};
