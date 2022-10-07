
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <cuda.h>

#define BLOCK_SIZE 4



void reduce(unsigned int *in, unsigned int *out,int size);
__device__ void scanBlock (unsigned int *in,int size);
__global__ void reduce1 (unsigned int *d_in, unsigned int *d_tmp,int size);
__global__ void reduce2 (unsigned int *d_in, int size);

int main(int argc, char **argv){
  if (argc < 2){
     printf("Usage: <filename>\n");
     exit(-1);
   }
   int size;
   unsigned int *vec;
   FILE *f = fopen(argv[1],"r");
   fscanf(f,"%d\n",&size);
   size = 1 << size;
   if (size >= (1 << 30)){
     printf("Size (%u) is too large: size is limited to 2^20\n",size);
     exit(-1);
   }
    vec = (unsigned int *) malloc(size * sizeof(unsigned int)); assert(vec);
   for (int i=0; i<size; i++){
     fscanf(f, "%u\n",&(vec[i]));
   }
   unsigned int sum=0;
   reduce(vec,&sum,size);
   printf("sum = %u\n", sum);

   unsigned int sum2 = 0;
   for (int i=0; i<size; i++){
     sum2 += vec[i];
   }
   printf("sum2 = %u\n", sum2);

   fclose(f);
   return 0;
}

void reduce(unsigned int *in,unsigned int *out, int size){

  unsigned int *d_in,*d_out,*d_tmp;

  int bytes = size*sizeof(unsigned int);
  int num_blocks = size / BLOCK_SIZE;
  if (size % BLOCK_SIZE) num_blocks ++;
  int bytes_block = num_blocks*sizeof(unsigned int);

  cudaMalloc((void **)&d_in, bytes);
  cudaMalloc((void **)&d_out, bytes) ;
  cudaMalloc((void **)&d_tmp, bytes_block);


  cudaMemcpy(d_in,in,bytes,cudaMemcpyHostToDevice);

  reduce1<<<num_blocks,BLOCK_SIZE>>>(d_in,d_tmp,size);
  //PARTIE 3
  
  if (num_blocks>BLOCK_SIZE){ // On re réduit 
    // calcul des differents tailles de blocs
    unsigned int *d_tmp2;
    int num_blocks2 = num_blocks / BLOCK_SIZE;
    int bytes_block2 = num_blocks2*sizeof(unsigned int);
    printf("nb sous blocs : %d \nnb blocs  : %d \n"  , num_blocks,num_blocks2);
    cudaMalloc((void **)&d_tmp2, bytes_block2);
    reduce1<<<num_blocks2,BLOCK_SIZE>>>(d_tmp,d_tmp2,num_blocks);
    reduce2<<<1,num_blocks2>>>(d_tmp2,num_blocks2);
    cudaMemcpy(out,d_tmp2,sizeof(unsigned int),cudaMemcpyDeviceToHost);
    cudaFree(d_tmp2);
  //PARTIE 2
  }else{
    reduce2<<<1,num_blocks>>>(d_tmp,num_blocks);
    cudaMemcpy(out,d_tmp,sizeof(unsigned int),cudaMemcpyDeviceToHost);
  }

  cudaFree(d_in);
  cudaFree(d_out);
  cudaFree(d_tmp);

}

__device__ void scanBlock (unsigned int *d_in,int size){
  int id=threadIdx.x;
  for(int i=size/2;i>=1;i>>=1){
    if(id<i && id+i<size){
      d_in[id]+=d_in[id+i];
    }
    __syncthreads();
    }
  

}

__global__ void reduce1 (unsigned int *d_in,unsigned int *d_tmp, int size ){
  int block_id = blockIdx.x;
  int offset = block_id * BLOCK_SIZE;
  int n = BLOCK_SIZE;
  if ( block_id == gridDim.x-1){   // dernier bloc ( si il n'est rempli )
    n = size-block_id*BLOCK_SIZE;
  }
  scanBlock(&(d_in[offset]),n);
  if (threadIdx.x== 0){
    d_tmp[block_id] = d_in[offset] ;
    # if __CUDA_ARCH__>=200
      printf("Block %d  -> %d \n", block_id,d_in[offset]);
    #endif

  }
}


__global__ void reduce2 (unsigned int *d_in,int size ){
  scanBlock(d_in,size);



}
