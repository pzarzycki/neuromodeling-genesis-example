float dt = 0.00005		// simulation time step in sec
setclock  0  {dt}		// set the simulation clock

float sep_x = 40e-6     // x cell distance [m]
float sep_y = 40e-6     // y cell distance [m]
float sep_z = 40e-6     // z cell distance [m]

include functions.g
include protodefs.g

readcell cell.p /cell

randseed

float probability = 0.01

int i,j

// create four retina reception fields 5x5
for (i=1; i<=2; i={i+1})
  for (j=1; j<=2; j={j+1})
    make_retina_reception_field /cell /net {i} {j} 5 5
  end
end

// create four cortical columns
for (i=1; i<=2 ; i={i+1})
  for (j=1; j<=2 ; j={j+1})
      make_cortical_column /cell /net {i} {j} 8 8 16
  end
end

// create network outputs
create_random_output /net 8 8 16 output-sim

// generate synapses 
for (i=1; i<=2 ; i={i+1})
  for (j=1; j<=2 ; j={j+1})
      wire_cortical_column /net {i} {j} 8 8 16 {probability}
      connect_reception_field_to_column /net {i} {j} 5 5 8 8 16 {probability}
  end
end


// create stimulation (diagonal pattern?)

create randomspike /input
setfield ^ min_amp 1 max_amp 1 rate 200 reset 1 reset_value 0

for (i=1; i<=10 ; i={i+2})
  for (j=1; j<=10 ; j={j+2})

    int fx = i / 5 + 1  // which reception field
    int fy = i / 5 + 1
    int x = i % 5 + 1   // which cell in reception field
    int y = i % 5 + 1

    make_synapse /input /net_retina_{fx}_{fy}_{x}_{y}/dend/Ex_channel 2 0

  end
end

make_synapse /input /net_retina_1_1_1_1/dend/Ex_channel 2 0
make_synapse /input /net_retina_1_2_1_1/dend/Ex_channel 2 0
make_synapse /input /net_retina_2_1_1_1/dend/Ex_channel 2 0
make_synapse /input /net_retina_2_2_1_1/dend/Ex_channel 2 0

reset
check

step 0.5 -time
quit


