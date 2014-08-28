__global__ void
exemple(void){
  int identifiant_local = threadIdx.x;
  int identifiant_global = blockIdx.x * blockDim.x + threadIdx.x;
}

int
main(){
  exemple<<<512,512>>>();
  return 0;
}
